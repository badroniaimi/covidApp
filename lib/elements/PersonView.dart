import 'package:anitcorona/Controllers/UserControllers.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class MyPersonView extends StatefulWidget {
  final MyUser person;

  const MyPersonView({Key? key, required this.person}) : super(key: key);

  @override
  _MyPersonViewState createState() => _MyPersonViewState();
}

class _MyPersonViewState extends State<MyPersonView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListTile(
        leading: IconButton(
          onPressed: () {
            // notification body
          },
          icon: Icon(
            Icons.person_rounded,
            color: Colors.grey[800],
            size: 30,
          ),
        ),
        title: Text(
          this.widget.person.name!,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 17),
        ),
        // trailing: SimpleActionButton(
        //   elevation: 0,
        //   width: 100,
        //   height: 30,
        //   isLoading: widget.person.isLoading,
        //   onTap: () {
        //     NearbyUsersControllers.getUploadsForUser(widget.person)
        //         .then((value) {
        //       setState(() {});
        //     });
        //     setState(() {});
        //   },
        //   child: Center(child: Text(S.of(context).getUploads)),
        // ),
        subtitle: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                "${S.of(context).userPhone}: ${this.widget.person.phoneNumber ?? " - "}",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              SelectableText(
                "${S.of(context).userEmail}: ${this.widget.person.email ?? " - "}",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              SelectableText(
                "${S.of(context).CIN}: ${MyUserController.cin ?? " - "}",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              // SelectableText(
              //   this.widget.person.address ?? "-",
              //   maxLines: 1,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
