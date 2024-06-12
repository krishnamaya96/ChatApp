import 'package:chat_app/Data/country_data.dart';
import 'package:chat_app/Models/country_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget{
  final Function(Country) onCountrySelected;

  const CountryList({super.key,required this.onCountrySelected});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController _searchController = TextEditingController();
  List<Country> _filteredCountries = countries;

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = countries;
      } else {
        _filteredCountries = countries
            .where((country) => country.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); },
              child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),),

            Spacer(),

            Text("Change number",
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,fontSize: 18),),
            Spacer(),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,

                  ),
                ),
                onChanged: _filterCountries,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = _filteredCountries[index];
                  return ListTile(
                    title: Text(country.name),
                    subtitle: Text(country.code),
                    onTap: () {
                      widget.onCountrySelected(country);
                      Navigator.of(context).pop();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailScreen(country: country),
                      //   ),
                      // );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}