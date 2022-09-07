import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'network/api_provider_repository.dart';
import 'package:user_details/model/user_detail_model.dart';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Center(
          child: Text("User Details"),
        ),
      ),
      body: const UserDetailsPage(),
    ),
  ));
}

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  UserDetails userDetails = UserDetails();
  List<Results>? results = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetailsFromNetwork();
  }

  @override
  Widget build(BuildContext context) {
    if (results!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(25, 50, 25, 0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90.0),
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: CachedNetworkImage(
                  imageUrl: userDetails.results![0].picture!.large!,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: ' ${userDetails.results![0].name!.title!} ',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${userDetails.results![0].name!.first!} ',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: userDetails.results![0].name!.last!,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Gender:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].gender!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Age:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].dob!.age}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Contact Num.:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].phone!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Address:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].location!.street!.name!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text:
                        ', ${userDetails.results![0].location!.street!.number}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ', ${userDetails.results![0].location!.city!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  // TextSpan(
                  //   text: ' ' + userDetails.results![0].location!.street!.name!,
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  TextSpan(
                    text: ' ${userDetails.results![0].location!.state!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Country:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].location!.country!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Login Details',
              style: TextStyle(
                  fontSize: 20.0, decoration: TextDecoration.underline),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Email:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].email!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Username:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].login!.username!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Password:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: ' ${userDetails.results![0].login!.password!}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  void getUserDetailsFromNetwork() {
    repository.userDetailsRepo().then((response) {
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          userDetails = UserDetails.fromJson(response.data);
          results = userDetails.results;
          // log('simant' + results.toString());
        });
      } else {
        setState(() {});
      }
    }, onError: (error) {});
  }
}
