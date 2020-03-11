import 'package:meta/meta.dart';

class SupportRole {
  // final Id<Roles> id;
  final String id;

  final String description;

  final String comment;

  final bool mandatory;

  final String name;

  final String uom;

  final String minHours;

  const SupportRole({
    @required this.id,
    @required this.name,
    @required this.comment,
    @required this.mandatory,
    @required this.description,
    @required this.uom,
     @required this.minHours,
  })  : assert(id != null),
        assert(name != null),
        assert(comment != null),
        assert(mandatory != null),
        assert(description != null),
        assert(minHours != null),
        assert(uom != null);

  // SupportRole.fromJson(dynamic data)
  //     :
  //       //id = Id<Roles>(data['id']),
  //       id = data['id'],
  //       description = data['description'],
  //       comment = data['comment'],
  //       name = data['name'],
  //       uom = data['uom'],
  //       mandatory = data['mandatory'] == '1' ? true : false;
}

List<SupportRole> mockSupportRoles = [
  SupportRole(
    id: "1",
    name: "Lawyer",
    comment: "",
    mandatory: false,
    description: "Provide legal advice and support to NVDA volunteers and leaders before, during, and after their interaction with police and the justice system. Law students and paralegls are also welcome",
    uom: "", minHours: "0",
    
  ),
  SupportRole(
    id: "1",
    name: "Lawyer",
    comment: "",
    mandatory: false,
    description: "Provide legal advice and support to NVDA volunteers and leaders before, during, and after their interaction with police and the justice system. Law students and paralegls are also welcome",
    uom: "", minHours: "0",
  ),
  SupportRole(
    id: "1",
    name: "Lawyer",
    comment: "",
    mandatory: false,
    description: "Provide legal advice and support to NVDA volunteers and leaders before, during, and after their interaction with police and the justice system. Law students and paralegls are also welcome",
    uom: "", minHours: "0",
  ),
];
