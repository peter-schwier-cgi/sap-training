// https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/ABENABAP_RAP.html
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.sapObjectNodeType.name: 'ZPCS02_LOG'
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
