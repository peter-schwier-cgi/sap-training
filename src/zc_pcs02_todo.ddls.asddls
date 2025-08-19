@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZPCS02_TODO000'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PCS02_TODO
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_PCS02_TODO
  association [1..1] to ZR_PCS02_TODO as _BaseEntity on $projection.UNIQUEID = _BaseEntity.UNIQUEID
{
  key UniqueID,
  ParentUniqueID,
  Title,
  Note,
  StartDate,
  DueDate,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
