import 'package:flutter/material.dart';
import '../models/city.dart';
import '../models/constants.dart';
import '../UI/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> cities =
        City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCity = City.getSelectedCities();

    Constants myConstants = Constants();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        title: Text(selectedCity.length.toString() + 'selected'),
      ),
      body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (BuildContext context, int idx) {
            return Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.08,
              width: size.width,
              decoration: BoxDecoration(
                border: cities[idx].isSelected == true
                    ? Border.all(
                        color: myConstants.secondaryColor.withOpacity(0.6),
                        width: 2,
                      )
                    : Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  Radius.circular(19),
                ),
                boxShadow: [
                  BoxShadow(
                    color: myConstants.primaryColor.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cities[idx].isSelected = !cities[idx].isSelected;
                      });
                    },
                    child: Image.asset(
                        cities[idx].isSelected == true
                            ? 'assets/checked.png'
                            : 'assets/unchecked.png',
                        width: 30),
                  ),
                  const SizedBox(width: 10),
                  Text(cities[idx].city,
                      style: TextStyle(
                        fontSize: 16,
                        color: cities[idx].isSelected == true
                            ? myConstants.primaryColor
                            : Colors.black54,
                      ))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myConstants.secondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        },
      ),
    );
  }
}
