import 'package:flutter/material.dart';
import 'package:weather/Pages/SearchPlaceWeather.dart';

class TamilNaduCitySearch extends StatefulWidget {
  const TamilNaduCitySearch({super.key});

  @override
  _TamilNaduCitySearchState createState() => _TamilNaduCitySearchState();
}

class _TamilNaduCitySearchState extends State<TamilNaduCitySearch> {
  final List<String> cityList = [
    "Chennai",
    "Coimbatore",
    "Madurai",
    "Tiruchirappalli",
    "Salem",
    "Tirunelveli",
    "Thoothukudi",
    "Erode",
    "Vellore",
    "Dindigul",
    "Thanjavur",
    "Nagercoil",
    "Karur",
    "Kanchipuram",
    "Cuddalore",
  ];

  final TextEditingController _controller = TextEditingController();
  String selectedCity = '';
  String errorText = '';
  List<String> filteredCities = [];

  void handleTextChanged(String value) {
    setState(() {
      filteredCities =
          cityList
              .where(
                (city) => city.toLowerCase().startsWith(value.toLowerCase()),
              )
              .toList();

      if (cityList.contains(value)) {
        selectedCity = value;
        errorText = '';
      } else {
        selectedCity = '';
        errorText = value.isEmpty ? '' : "Name not applicable";
      }
    });
  }

  void handleCityTap(String city) {
    setState(() {
      selectedCity = city;
      _controller.text = city; // 🔥 Update search bar
      filteredCities =
          cityList
              .where((c) => c.toLowerCase().startsWith(city.toLowerCase()))
              .toList();
      errorText = '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredCities = List.from(cityList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Sky.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Search cities",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: TextField(
                    controller: _controller,
                    onChanged: handleTextChanged,
                    onSubmitted: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => home(cityName: value),
                        ),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "City Name",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white, width: 5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white, width: 5.0),
                      ),
                    ),
                  ),
                ),
              ),
              if (errorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(maxHeight: 500),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 5.0),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    return ListTile(
                      title: Text(
                        city,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        handleCityTap(city);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(cityName: city),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              if (selectedCity.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Selected City: $selectedCity",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
