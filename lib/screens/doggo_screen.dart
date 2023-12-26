import 'package:doggo_dec_18/helpers/ui_helper.dart';
import 'package:doggo_dec_18/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_18/services/doggo_service/doggo_service.dart';
import 'package:doggo_dec_18/services/service_result.dart';
import 'package:flutter/material.dart';

class DoggoScreen extends StatefulWidget {
  final DoggoService doggoService;

  const DoggoScreen({super.key, required this.doggoService});

  @override
  State<StatefulWidget> createState() => _DoggoScreenState();
}

class _DoggoScreenState extends State<DoggoScreen> {
  bool dogsLoaded = false;
  late List<DoggoBreed> dogBreeds;
  bool isLoadingInitialList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Doggo Diversity Showcase"),
          backgroundColor: Colors.deepPurpleAccent.shade100),
      body: Column(children: [
        _buildButtonContainer(),
        if (isLoadingInitialList)
          const Center(child: CircularProgressIndicator()),
        if (dogsLoaded)
          Expanded(
            child: _buildDoggoBreedList(),
          )
      ]),
    );
  }

  Widget _buildButtonContainer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 9, bottom: 10),
      child: ElevatedButton(
        onPressed: _handleRequestButtonPressed,
        child: const Text("List dogs, please!"),
      ),
    );
  }

  void _handleRequestButtonPressed() async {
    if (dogsLoaded != true && isLoadingInitialList != true) {
      setState(() {
        isLoadingInitialList = true;
      });
    }

    // Fetch data from service (await)
    ServiceResult doggoBreedsResult = await widget.doggoService.getBreeds();

    // Check if the buildcontext is still mounted (aka this screen still exists), else return
    if (!context.mounted) return;

    // Check if the service returned a successful response to the request, else show gracious UX snackbar and return
    if (doggoBreedsResult.success != true) {
      if (isLoadingInitialList == true) {
        setState(() {
          isLoadingInitialList = false;
        });
      }

      UiHelper.displaySnackbar(context,
          "There was an error fetching the list of doggos from the service. Please try again later");
      return;
    }
    // If everything checks out, set state. Set the dog list variable and the flag that notifies the list has been set.
    setState(() {
      dogBreeds = doggoBreedsResult.data!;
      dogsLoaded = true;
      isLoadingInitialList = false;
    });
  }

  Widget _buildDoggoBreedList() {
    return ListView.builder(
      itemBuilder: _doggoBreedItemBuilder,
      itemCount: dogBreeds.length,
    );
  }

  Widget _doggoBreedItemBuilder(context, index) {
    return Card(
      child: ListTile(
        title: Text(dogBreeds[index].name),
        subtitle: (dogBreeds[index].temperament == null)
            ? null
            : Text(dogBreeds[index].temperament!),
      ),
    );
  }
}
