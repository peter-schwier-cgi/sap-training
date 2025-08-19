@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPCS02_TODO000'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PCS02_TODO
  as select from zpcs02_todo
{
  key unique_id             as UniqueID,
      parent_unique_id      as ParentUniqueID,
      title                 as Title,
      note                  as Note,
      start_date            as StartDate,
      due_date              as DueDate,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
