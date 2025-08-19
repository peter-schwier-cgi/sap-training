@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@ObjectModel.sapObjectNodeType.name: 'ZPCS02_LOG'
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #L,
    dataClass: #TRANSACTIONAL
}
define root view entity ZR_PCS02_LOG
  as select from zpcs02_log
{
  key timestamp as Timestamp,
  key unique_id as UniqueId,
  re_unique_id as ReUniqueId,
  note as Note,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
  
}
