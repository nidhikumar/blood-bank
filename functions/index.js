/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
admin.initializeApp();

// Configure the email transport using the default SMTP transport and a GMail account.
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'your-email@gmail.com', // replace with your email
    pass: 'your-email-password'  // replace with your email password or app-specific password
  }
});

// Cloud Function to send email when a blood donation request is made
exports.sendBloodRequestEmail = functions.firestore
  .document('donation_requests/{requestId}')
  .onCreate(async (snap, context) => {
    const request = snap.data();
    const bloodGroup = request.bloodGroup;
    const timestamp = request.timestamp.toDate().toLocaleDateString();

    // Query to get all donors with the same blood group
    const donorsSnapshot = await admin.firestore().collection('donor_list')
      .where('bloodGroup', '==', bloodGroup)
      .get();

    const emails = donorsSnapshot.docs.map(doc => doc.data().email);

    const mailOptions = {
      from: 'your-email@gmail.com',
      to: emails.join(','),
      subject: `${bloodGroup} blood required!`,
      text: `A request for ${bloodGroup} blood has been made on ${timestamp}. Please consider donating.`
    };

    try {
      await transporter.sendMail(mailOptions);
      console.log('Emails sent to:', emails);
    } catch (error) {
      console.error('Error sending email:', error);
    }
  });
