///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const ListSupportRoleRequest$json = const {
  '1': 'ListSupportRoleRequest',
  '2': const [
    const {'1': 'org_id', '3': 1, '4': 1, '5': 9, '10': 'orgId'},
  ],
};

const GetSupportRoleRequest$json = const {
  '1': 'GetSupportRoleRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const Orgs$json = const {
  '1': 'Orgs',
  '2': const [
    const {'1': 'orgs', '3': 1, '4': 3, '5': 11, '6': '.proto.Org', '10': 'orgs'},
  ],
};

const ListOrgRequest$json = const {
  '1': 'ListOrgRequest',
};

const GetOrgRequest$json = const {
  '1': 'GetOrgRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const NewAnswerRequest$json = const {
  '1': 'NewAnswerRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sel_support_role_id', '3': 2, '4': 1, '5': 9, '10': 'selSupportRoleId'},
    const {'1': 'sel_campaign_id', '3': 3, '4': 1, '5': 9, '10': 'selCampaignId'},
    const {'1': 'min_hours_pledged', '3': 4, '4': 1, '5': 9, '10': 'minHoursPledged'},
  ],
};

const Answer$json = const {
  '1': 'Answer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sel_support_role_id', '3': 2, '4': 1, '5': 9, '10': 'selSupportRoleId'},
    const {'1': 'sel_campaign_id', '3': 3, '4': 1, '5': 9, '10': 'selCampaignId'},
    const {'1': 'min_hours_pledged', '3': 4, '4': 1, '5': 9, '10': 'minHoursPledged'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

const Answers$json = const {
  '1': 'Answers',
  '2': const [
    const {'1': 'answers', '3': 1, '4': 3, '5': 11, '6': '.proto.Answer', '10': 'answers'},
  ],
};

const SupportRole$json = const {
  '1': 'SupportRole',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'comment', '3': 3, '4': 1, '5': 9, '10': 'comment'},
    const {'1': 'mandatory', '3': 4, '4': 1, '5': 8, '10': 'mandatory'},
    const {'1': 'uom', '3': 5, '4': 1, '5': 9, '10': 'uom'},
    const {'1': 'min_hours', '3': 6, '4': 1, '5': 9, '10': 'minHours'},
    const {'1': 'campaign_id', '3': 7, '4': 1, '5': 9, '10': 'campaignId'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

const Org$json = const {
  '1': 'Org',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'campaign_name', '3': 2, '4': 1, '5': 9, '10': 'campaignName'},
    const {'1': 'logo_url', '3': 3, '4': 1, '5': 9, '10': 'logoUrl'},
    const {'1': 'goal', '3': 4, '4': 1, '5': 9, '10': 'goal'},
    const {'1': 'crg_quantity_many', '3': 5, '4': 3, '5': 9, '10': 'crgQuantityMany'},
    const {'1': 'crg_ids_many', '3': 6, '4': 3, '5': 9, '10': 'crgIdsMany'},
    const {'1': 'already_pledged', '3': 7, '4': 1, '5': 9, '10': 'alreadyPledged'},
    const {'1': 'action_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'actionTime'},
    const {'1': 'action_location', '3': 9, '4': 1, '5': 9, '10': 'actionLocation'},
    const {'1': 'campaign_still', '3': 10, '4': 1, '5': 9, '10': 'campaignStill'},
    const {'1': 'min_pioneers', '3': 11, '4': 1, '5': 9, '10': 'minPioneers'},
    const {'1': 'min_rebels_for_media', '3': 12, '4': 1, '5': 9, '10': 'minRebelsForMedia'},
    const {'1': 'min_rebels_to_win', '3': 13, '4': 1, '5': 9, '10': 'minRebelsToWin'},
    const {'1': 'action_length', '3': 14, '4': 1, '5': 9, '10': 'actionLength'},
    const {'1': 'action_type', '3': 15, '4': 1, '5': 9, '10': 'actionType'},
    const {'1': 'backing_org', '3': 16, '4': 3, '5': 9, '10': 'backingOrg'},
    const {'1': 'category', '3': 17, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'contact', '3': 18, '4': 1, '5': 9, '10': 'contact'},
    const {'1': 'hist_precedents', '3': 19, '4': 1, '5': 9, '10': 'histPrecedents'},
    const {'1': 'organization', '3': 20, '4': 1, '5': 9, '10': 'organization'},
    const {'1': 'strategy', '3': 21, '4': 1, '5': 9, '10': 'strategy'},
    const {'1': 'video_url', '3': 22, '4': 3, '5': 9, '10': 'videoUrl'},
    const {'1': 'uom', '3': 23, '4': 1, '5': 9, '10': 'uom'},
  ],
};

const NewAnswerResponse$json = const {
  '1': 'NewAnswerResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
  ],
};

const DeleteAnswerResponse$json = const {
  '1': 'DeleteAnswerResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

const AnswerIdRequest$json = const {
  '1': 'AnswerIdRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const SupportRoles$json = const {
  '1': 'SupportRoles',
  '2': const [
    const {'1': 'support_roles', '3': 1, '4': 3, '5': 11, '6': '.proto.SupportRole', '10': 'supportRoles'},
  ],
};

