import 'dart:io';
import 'package:eco_buy/models/productsModel.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_dialogue.dart';
import 'package:eco_buy/widgets/ecotextfeild.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddProductsScreen extends StatefulWidget {
  static const String id = 'add';

  AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  bool isOnSale = false;
  bool isPopular = false;
  bool isFavorite = false;
  var uuid = const Uuid();

  String? selectedValue;
  final imagePicker = ImagePicker();
  List<XFile> imageList = [];
  List<String> imageUrls = [];
  bool isSaving = false;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    List categories = [
      "GROCERY",
      "PHARMACY",
      "COSMETICS",
      "ELECTRONICS",
      'GARMENTS',
    ];

    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Column(
              children: [
                const Text(
                  'ADD PRODUCTS SCREEN',
                  style: TextStyle(fontSize: 25),
                ),
                EcoButton(
                  title: "PICK IMAGES",
                  onPress: () {
                    pickImage();
                  },
                  isLoginButton: true,
                ),
                Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemCount: imageList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.network(
                              //image path and directory path
                              File(imageList[index].path).path,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  imageList.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        hint: const Text('Select category'),
                        iconEnabledColor: Colors.grey,
                        iconDisabledColor: Colors.grey,
                        alignment: Alignment.center,
                        borderRadius: BorderRadius.circular(10),
                        value: selectedValue,
                        items: categories
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            print(selectedValue);
                          });
                        }),
                  ),
                ),
                const SizedBox(height: 10),
                EcoField(
                  isFilledColor: true,
                  controller: productNameC,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  hintText: 'Enter product name',
                ),
                const SizedBox(height: 10),
                EcoField(
                  isFilledColor: true,
                  controller: serialCodeC,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  hintText: 'Enter serial code',
                ),
                const SizedBox(height: 10),
                EcoField(
                  isFilledColor: true,
                  minLines: 5,
                  controller: detailC,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  hintText: 'Enter product detail',
                ),
                const SizedBox(height: 10),
                EcoField(
                  isFilledColor: true,
                  controller: priceC,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  hintText: 'Enter product price',
                ),
                const SizedBox(height: 10),
                EcoField(
                  isFilledColor: true,
                  controller: discountPriceC,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  hintText: 'Enter product discounted price',
                ),
                const SizedBox(height: 10),
                EcoField(
                  isFilledColor: true,
                  controller: brandC,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  hintText: 'Enter brand name',
                ),
                SwitchListTile(
                    title: const Text('Is on sale'),
                    value: isOnSale,
                    onChanged: (value) {
                      setState(() {
                        isOnSale = !isOnSale;
                      });
                    }),
                SwitchListTile(
                    title: const Text('Is on sale'),
                    value: isPopular,
                    onChanged: (value) {
                      setState(() {
                        isPopular = !isPopular;
                      });
                    }),
                EcoButton(
                  isLoading: isSaving,
                  onPress: () {
                    save();
                  },
                  title: 'SAVE',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Products.addProducts(
      Products(
        category: selectedValue,
        id: uuid.v4(),
        brand: brandC.text,
        productName: productNameC.text,
        detail: detailC.text,
        price: int.parse(priceC.text),
        discountPrice: int.parse(discountPriceC.text),
        serialCode: serialCodeC.text,
        imageUrls: imageUrls,
        isSale: isOnSale,
        isPopular: isPopular,
        isFavourite: isFavorite,
      ),
    ).whenComplete(() {
      setState(() {
        isSaving = false;
        imageUrls.clear();
        imageList.clear();
        clearFields();
        const SnackBar(
            content: EcoDialog(
          title: 'Added Sucessfully',
        ));
      });
    });
    // await FirebaseFirestore.instance
    //     .collection("products")
    //     .add({"images": imageUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageUrls.clear();
    //   });
    // });
  }

  clearFields() {
    setState(() {
      // selectedValue = "";
      // productNameC.clear();
      // detailC.clear();
    });
  }

  pickImage() async {
    final List<XFile> pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      print('image pick = ${pickImage[0].path}');
      print('image pick = ${pickImage[0].name}');
      setState(() {
        imageList.addAll(pickImage);
      });
    } else {
      print('No Images Selected');
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String urls;
    Reference ref =
        //ref .child("images means name of folder will be images")
        //mene ek location bnadi ha storage k andr, k firestore ka instance create kre usme ek images
        //k naam se folders banaye aur saari images save hoajye
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);
    if (kIsWeb) {
      //Every file will be converted into bytes
      await ref.putData(await imageFile.readAsBytes());
      //type of data
      SettableMetadata(contentType: "image/jpeg");
      //get urls because colud storage can save data but cloud firestore cant store data so we send links as wel
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in imageList) {
      await postImages(image).then((downloadUrl) => imageUrls.add(downloadUrl));
    }
  }
}
