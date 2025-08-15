@Metadata.allowExtensions: true
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Entity for ZPCS02_LOG'
@Metadata.ignorePropagatedAnnotations: true
// @ObjectModel.sapObjectNodeType.name: 'ZPCS02_LOG'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_PCS02_LOG
  provider contract transactional_query
  as projection on ZR_PCS02_LOG
{
  key Timestamp,
  key UniqueId,
      ReUniqueId,
      Note,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedBy,
      LastChangedAt
}
