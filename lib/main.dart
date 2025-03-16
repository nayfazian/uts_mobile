import 'package:flutter/material.dart';
import 'converter.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konversi Suhu',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Montserrat', // Font elegan
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  double _inputValue = 0.0;
  double _convertedValue = 0.0;
  String _selectedUnit = 'Celsius ke Fahrenheit';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    setState(() {
      _convertedValue = TemperatureConverter.convert(_inputValue, _selectedUnit);
      String historyText =
          '$_inputValue° ${_selectedUnit.split(" ")[0]} = $_convertedValue° ${_selectedUnit.split(" ")[2]}';
      _conversionHistory.insert(0, historyText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Konversi Suhu 🌸",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Playfair Display',
                  ),
                ),
                SizedBox(height: 20),

                // Card untuk input & konversi
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Masukkan suhu',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _inputValue = double.tryParse(value) ?? 0.0;
                            });
                          },
                        ),
                        SizedBox(height: 10),

                        // Dropdown pilihan konversi
                        DropdownButton<String>(
                          value: _selectedUnit,
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedUnit = newValue!;
                              _convertTemperature();
                            });
                          },
                          items: <String>[
                            'Celsius ke Fahrenheit',
                            'Fahrenheit ke Celsius',
                            'Celsius ke Kelvin',
                            'Kelvin ke Celsius'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),

                        // Tombol Konversi
                        ElevatedButton(
                          onPressed: _convertTemperature,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                          child: Text(
                            'Konversi',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Hasil konversi
                        Text(
                          'Hasil: ${_convertedValue.toStringAsFixed(2)}°',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Riwayat Konversi
                Expanded(
                  child: ListView.builder(
                    itemCount: _conversionHistory.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            _conversionHistory[index],
                            style: TextStyle(color: Colors.pink.shade800),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
