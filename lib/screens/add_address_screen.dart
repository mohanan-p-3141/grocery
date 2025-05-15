import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:grocery/models/address_model.dart';
import 'package:grocery/provider/address_provider.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  final int? editIndex;
  final AddressModel? existing;

  const AddAddressScreen({this.editIndex, this.existing});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController addressLineController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController floorNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String fullLocation = '';
  LatLng? currentLatLng;

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      addressLineController.text = widget.existing!.addressLine;
      streetController.text = widget.existing!.street;
      houseNoController.text = widget.existing!.houseNo;
      floorNoController.text = widget.existing!.floorNo;
      nameController.text = widget.existing!.name;
      phoneController.text = widget.existing!.phone;
      fullLocation = widget.existing!.fullLocation;
    } else {
      _fetchAndAutoFillLocation();
    }
  }

  Future<void> _fetchAndAutoFillLocation() async {
    try {
      final pos = await _getCurrentLocation();
      currentLatLng = LatLng(pos.latitude, pos.longitude);
      final address = await _getAddressFromLatLng(currentLatLng!);
      setState(() {
        fullLocation = address;
        addressLineController.text = address;
      });
    } catch (e) {
      print("Location Error: $e");
      setState(() {
        fullLocation = "Unable to fetch location.";
      });
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return "${place.name}, ${place.street}, ${place.locality}, ${place.postalCode}";
    }
    return "Unknown Location";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.editIndex != null ? 'Edit Address' : 'Add New Address')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 200,
              child: currentLatLng == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLatLng!,
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                    ),
            ),
            const SizedBox(height: 12),
            Text("Live Location: $fullLocation", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            TextFormField(controller: addressLineController, decoration: InputDecoration(labelText: 'Address Line')),
            TextFormField(controller: streetController, decoration: InputDecoration(labelText: 'Street Number')),
            Row(
              children: [
                Expanded(child: TextFormField(controller: houseNoController, decoration: InputDecoration(labelText: 'House No'))),
                const SizedBox(width: 10),
                Expanded(child: TextFormField(controller: floorNoController, decoration: InputDecoration(labelText: 'Floor No'))),
              ],
            ),
            TextFormField(controller: nameController, decoration: InputDecoration(labelText: 'Contact Name')),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newAddress = AddressModel(
                    addressLine: addressLineController.text,
                    street: streetController.text,
                    houseNo: houseNoController.text,
                    floorNo: floorNoController.text,
                    name: nameController.text,
                    phone: phoneController.text,
                    fullLocation: fullLocation,
                  );

                  if (widget.editIndex != null) {
                    provider.editAddress(widget.editIndex!, newAddress);
                  } else {
                    provider.addAddress(newAddress);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text('Save Location'),
            ),
          ],
        ),
      ),
    );
  }
}
