/* This file was generated by upb_generator from the input file:
 *
 *     envoy/config/trace/v3/service.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#ifndef ENVOY_CONFIG_TRACE_V3_SERVICE_PROTO_UPB_H_
#define ENVOY_CONFIG_TRACE_V3_SERVICE_PROTO_UPB_H_

#include "upb/generated_code_support.h"

#include "envoy/config/trace/v3/service.upb_minitable.h"

#include "envoy/config/core/v3/grpc_service.upb_minitable.h"
#include "udpa/annotations/status.upb_minitable.h"
#include "udpa/annotations/versioning.upb_minitable.h"
#include "validate/validate.upb_minitable.h"

// Must be last.
#include "upb/port/def.inc"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct envoy_config_trace_v3_TraceServiceConfig envoy_config_trace_v3_TraceServiceConfig;
struct envoy_config_core_v3_GrpcService;



/* envoy.config.trace.v3.TraceServiceConfig */

UPB_INLINE envoy_config_trace_v3_TraceServiceConfig* envoy_config_trace_v3_TraceServiceConfig_new(upb_Arena* arena) {
  return (envoy_config_trace_v3_TraceServiceConfig*)_upb_Message_New(&envoy__config__trace__v3__TraceServiceConfig_msg_init, arena);
}
UPB_INLINE envoy_config_trace_v3_TraceServiceConfig* envoy_config_trace_v3_TraceServiceConfig_parse(const char* buf, size_t size, upb_Arena* arena) {
  envoy_config_trace_v3_TraceServiceConfig* ret = envoy_config_trace_v3_TraceServiceConfig_new(arena);
  if (!ret) return NULL;
  if (upb_Decode(buf, size, ret, &envoy__config__trace__v3__TraceServiceConfig_msg_init, NULL, 0, arena) != kUpb_DecodeStatus_Ok) {
    return NULL;
  }
  return ret;
}
UPB_INLINE envoy_config_trace_v3_TraceServiceConfig* envoy_config_trace_v3_TraceServiceConfig_parse_ex(const char* buf, size_t size,
                           const upb_ExtensionRegistry* extreg,
                           int options, upb_Arena* arena) {
  envoy_config_trace_v3_TraceServiceConfig* ret = envoy_config_trace_v3_TraceServiceConfig_new(arena);
  if (!ret) return NULL;
  if (upb_Decode(buf, size, ret, &envoy__config__trace__v3__TraceServiceConfig_msg_init, extreg, options, arena) !=
      kUpb_DecodeStatus_Ok) {
    return NULL;
  }
  return ret;
}
UPB_INLINE char* envoy_config_trace_v3_TraceServiceConfig_serialize(const envoy_config_trace_v3_TraceServiceConfig* msg, upb_Arena* arena, size_t* len) {
  char* ptr;
  (void)upb_Encode(msg, &envoy__config__trace__v3__TraceServiceConfig_msg_init, 0, arena, &ptr, len);
  return ptr;
}
UPB_INLINE char* envoy_config_trace_v3_TraceServiceConfig_serialize_ex(const envoy_config_trace_v3_TraceServiceConfig* msg, int options,
                                 upb_Arena* arena, size_t* len) {
  char* ptr;
  (void)upb_Encode(msg, &envoy__config__trace__v3__TraceServiceConfig_msg_init, options, arena, &ptr, len);
  return ptr;
}
UPB_INLINE void envoy_config_trace_v3_TraceServiceConfig_clear_grpc_service(envoy_config_trace_v3_TraceServiceConfig* msg) {
  const upb_MiniTableField field = {1, UPB_SIZE(4, 8), 1, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)};
  _upb_Message_ClearNonExtensionField(msg, &field);
}
UPB_INLINE const struct envoy_config_core_v3_GrpcService* envoy_config_trace_v3_TraceServiceConfig_grpc_service(const envoy_config_trace_v3_TraceServiceConfig* msg) {
  const struct envoy_config_core_v3_GrpcService* default_val = NULL;
  const struct envoy_config_core_v3_GrpcService* ret;
  const upb_MiniTableField field = {1, UPB_SIZE(4, 8), 1, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)};
  _upb_Message_GetNonExtensionField(msg, &field, &default_val, &ret);
  return ret;
}
UPB_INLINE bool envoy_config_trace_v3_TraceServiceConfig_has_grpc_service(const envoy_config_trace_v3_TraceServiceConfig* msg) {
  const upb_MiniTableField field = {1, UPB_SIZE(4, 8), 1, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)};
  return _upb_Message_HasNonExtensionField(msg, &field);
}

UPB_INLINE void envoy_config_trace_v3_TraceServiceConfig_set_grpc_service(envoy_config_trace_v3_TraceServiceConfig *msg, struct envoy_config_core_v3_GrpcService* value) {
  const upb_MiniTableField field = {1, UPB_SIZE(4, 8), 1, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)};
  _upb_Message_SetNonExtensionField(msg, &field, &value);
}
UPB_INLINE struct envoy_config_core_v3_GrpcService* envoy_config_trace_v3_TraceServiceConfig_mutable_grpc_service(envoy_config_trace_v3_TraceServiceConfig* msg, upb_Arena* arena) {
  struct envoy_config_core_v3_GrpcService* sub = (struct envoy_config_core_v3_GrpcService*)envoy_config_trace_v3_TraceServiceConfig_grpc_service(msg);
  if (sub == NULL) {
    sub = (struct envoy_config_core_v3_GrpcService*)_upb_Message_New(&envoy__config__core__v3__GrpcService_msg_init, arena);
    if (sub) envoy_config_trace_v3_TraceServiceConfig_set_grpc_service(msg, sub);
  }
  return sub;
}

#ifdef __cplusplus
}  /* extern "C" */
#endif

#include "upb/port/undef.inc"

#endif  /* ENVOY_CONFIG_TRACE_V3_SERVICE_PROTO_UPB_H_ */
