/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Automatically generated nanopb header */
/* Generated by nanopb-0.3.9.9 */

#ifndef PB_FM_ME_NANOPB_H_INCLUDED
#define PB_FM_ME_NANOPB_H_INCLUDED
#include <nanopb/pb.h>

/* @@protoc_insertion_point(includes) */
#if PB_PROTO_HEADER_VERSION != 30
#error Regenerate this file with the current version of nanopb generator.
#endif


/* Enum definitions */
typedef enum _fm_MessagingClientEvent_MessageType {
    fm_MessagingClientEvent_MessageType_UNKNOWN = 0,
    fm_MessagingClientEvent_MessageType_DATA_MESSAGE = 1,
    fm_MessagingClientEvent_MessageType_TOPIC = 2,
    fm_MessagingClientEvent_MessageType_DISPLAY_NOTIFICATION = 3
} fm_MessagingClientEvent_MessageType;
#define _fm_MessagingClientEvent_MessageType_MIN fm_MessagingClientEvent_MessageType_UNKNOWN
#define _fm_MessagingClientEvent_MessageType_MAX fm_MessagingClientEvent_MessageType_DISPLAY_NOTIFICATION
#define _fm_MessagingClientEvent_MessageType_ARRAYSIZE ((fm_MessagingClientEvent_MessageType)(fm_MessagingClientEvent_MessageType_DISPLAY_NOTIFICATION+1))

typedef enum _fm_MessagingClientEvent_SDKPlatform {
    fm_MessagingClientEvent_SDKPlatform_UNKNOWN_OS = 0,
    fm_MessagingClientEvent_SDKPlatform_ANDROID = 1,
    fm_MessagingClientEvent_SDKPlatform_IOS = 2,
    fm_MessagingClientEvent_SDKPlatform_WEB = 3
} fm_MessagingClientEvent_SDKPlatform;
#define _fm_MessagingClientEvent_SDKPlatform_MIN fm_MessagingClientEvent_SDKPlatform_UNKNOWN_OS
#define _fm_MessagingClientEvent_SDKPlatform_MAX fm_MessagingClientEvent_SDKPlatform_WEB
#define _fm_MessagingClientEvent_SDKPlatform_ARRAYSIZE ((fm_MessagingClientEvent_SDKPlatform)(fm_MessagingClientEvent_SDKPlatform_WEB+1))

typedef enum _fm_MessagingClientEvent_Event {
    fm_MessagingClientEvent_Event_UNKNOWN_EVENT = 0,
    fm_MessagingClientEvent_Event_MESSAGE_DEstepOutRED = 1,
    fm_MessagingClientEvent_Event_MESSAGE_OPEN = 2
} fm_MessagingClientEvent_Event;
#define _fm_MessagingClientEvent_Event_MIN fm_MessagingClientEvent_Event_UNKNOWN_EVENT
#define _fm_MessagingClientEvent_Event_MAX fm_MessagingClientEvent_Event_MESSAGE_OPEN
#define _fm_MessagingClientEvent_Event_ARRAYSIZE ((fm_MessagingClientEvent_Event)(fm_MessagingClientEvent_Event_MESSAGE_OPEN+1))

/* Struct definitions */
typedef struct _fm_MessagingClientEventExtension {
    struct _fm_MessagingClientEvent *messaging_client_event;
/* @@protoc_insertion_point(struct:fm_MessagingClientEventExtension) */
} fm_MessagingClientEventExtension;

typedef struct _fm_MessagingClientEvent {
    int64_t project_number;
    pb_bytes_array_t *message_id;
    pb_bytes_array_t *instance_id;
    fm_MessagingClientEvent_MessageType message_type;
    fm_MessagingClientEvent_SDKPlatform sdk_platform;
    pb_bytes_array_t *package_name;
    fm_MessagingClientEvent_Event event;
    pb_bytes_array_t *analytics_label;
    int64_t campaign_id;
    pb_bytes_array_t *composer_label;
/* @@protoc_insertion_point(struct:fm_MessagingClientEvent) */
} fm_MessagingClientEvent;

/* Default values for struct fields */

/* Initializer values for message structs */
#define fm_MessagingClientEvent_init_default     {0, NULL, NULL, _fm_MessagingClientEvent_MessageType_MIN, _fm_MessagingClientEvent_SDKPlatform_MIN, NULL, _fm_MessagingClientEvent_Event_MIN, NULL, 0, NULL}
#define fm_MessagingClientEventExtension_init_default {NULL}
#define fm_MessagingClientEvent_init_zero        {0, NULL, NULL, _fm_MessagingClientEvent_MessageType_MIN, _fm_MessagingClientEvent_SDKPlatform_MIN, NULL, _fm_MessagingClientEvent_Event_MIN, NULL, 0, NULL}
#define fm_MessagingClientEventExtension_init_zero {NULL}

/* Field tags (for use in manual encoding/decoding) */
#define fm_MessagingClientEventExtension_messaging_client_event_tag 1
#define fm_MessagingClientEvent_project_number_tag 1
#define fm_MessagingClientEvent_message_id_tag   2
#define fm_MessagingClientEvent_instance_id_tag  3
#define fm_MessagingClientEvent_message_type_tag 4
#define fm_MessagingClientEvent_sdk_platform_tag 5
#define fm_MessagingClientEvent_package_name_tag 6
#define fm_MessagingClientEvent_event_tag        12
#define fm_MessagingClientEvent_analytics_label_tag 13
#define fm_MessagingClientEvent_campaign_id_tag  14
#define fm_MessagingClientEvent_composer_label_tag 15

/* Struct field encoding specification for nanopb */
extern const pb_field_t fm_MessagingClientEvent_fields[11];
extern const pb_field_t fm_MessagingClientEventExtension_fields[2];

/* Maximum encoded size of messages (where known) */
/* fm_MessagingClientEvent_size depends on runtime parameters */
/* fm_MessagingClientEventExtension_size depends on runtime parameters */

/* Message IDs (where set with "msgid" option) */
#ifdef PB_MSGID

#define ME_MESSAGES \


#endif

/* @@protoc_insertion_point(eof) */

#endif
