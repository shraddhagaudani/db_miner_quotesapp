import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:db_miner_quotesapp/controllers/app_controllers.dart';
import 'package:db_miner_quotesapp/models/quotes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  EditingController editingController = Get.put(EditingController());
  ScreenshotController screenshotController = ScreenshotController();

  void savegallery() async {
    Uint8List? capturedImage = await screenshotController.capture();

    if (capturedImage != null) {
      await ImageGallerySaver.saveImage(capturedImage);
      Get.snackbar(
        'Success',
        'Image saved successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to save image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  Future<void> setWallpaper({required wallpaperLocation}) async {


    Uint8List? uint8list = await screenshotController.capture();

    if (uint8list != null) {
      final directory = (await getTemporaryDirectory()).path;

      final imagePath = '$directory/screenshot.png';

      File imageFile = File(imagePath);

      await imageFile.writeAsBytes(uint8list);

// Set the wallpaper from the file
      await AsyncWallpaper.setWallpaperFromFile(
        filePath: imagePath,
        wallpaperLocation: wallpaperLocation,
      );
    }
  }


  List<Color> containerColor = [
    Colors.red.shade300,
    Colors.red.shade300,
    Colors.grey.shade300,
    Colors.green.shade300,
    Colors.pink.shade300,
    Colors.pinkAccent.shade400,
    Colors.purple.shade300,
    Colors.purpleAccent.shade400,
    Colors.blueGrey.shade300,
  ];
  List<Color> fontColor = [
    Colors.red,
    Colors.red,
    Colors.grey,
    Colors.green,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.blueGrey,
  ];

  List<String?> googleFonts = [
    GoogleFonts.openSans().fontFamily,
    GoogleFonts.lato().fontFamily,
    GoogleFonts.montserrat().fontFamily,
    GoogleFonts.quicksand().fontFamily,
    GoogleFonts.roboto().fontFamily,
  ];

  Color selectedBackgroundColor = Colors.grey;
  Color selectedFontColor = Colors.black;
  int currentFontIndex = 0;

  @override
  Widget build(BuildContext context) {
    DatabaseSecond_Model? data = Get.arguments as DatabaseSecond_Model?;

    return GetBuilder<EditingController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Page"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      height: Get.height * 0.5,
                      width: Get.width * 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedBackgroundColor),
                      child: Column(
                        children: [
                          Text(
                            data!.quote,
                            style: TextStyle(
                                fontSize: editingController.editingModel.textsize
                                    .toDouble(),
                                color: selectedFontColor,
                                fontFamily: googleFonts[currentFontIndex]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Font Size",
                        style: GoogleFonts.hind(fontWeight: FontWeight.bold),
                        // style: TextStyle(
                        //     fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          editingController.increaseTextSize();
                        },
                        icon: const Icon(CupertinoIcons.plus_app_fill),
                      ),
                      const Text(
                        "1.8",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        onPressed: () {
                          editingController.decreaseTextSize();
                        },
                        icon: const Icon(CupertinoIcons.minus_square_fill),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Background Color",
                          style: GoogleFonts.hind(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    height: Get.height * 0.4,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Select Color",
                                                  style: GoogleFonts.hind(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 8.0,
                                              crossAxisSpacing: 8.0,
                                            ),
                                            itemCount: containerColor.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedBackgroundColor =
                                                        containerColor[index];
                                                    // showImages = false;
                                                  });
                                                  Get.back();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        containerColor[index],
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(Icons.color_lens),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Font Color",
                          style: GoogleFonts.hind(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    height: Get.height * 0.4,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Select Color",
                                                  style: GoogleFonts.hind(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 8.0,
                                              crossAxisSpacing: 8.0,
                                            ),
                                            itemCount: fontColor.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedFontColor =
                                                        fontColor[index];
                                                  });
                                                  Get.back();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: fontColor[index],
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(Icons.color_lens),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Font Style",
                          style: GoogleFonts.hind(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentFontIndex = (currentFontIndex + 1) %
                                      googleFonts.length;
                                });
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(Icons.text_format_outlined),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: savegallery,
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.3,
                          decoration: (BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.save),
                              Text(
                                "Save",
                                style: GoogleFonts.hind(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: data.quote))
                              .then(
                                (value) => Get.snackbar(
                              "Quote",
                              "Successfully Copy",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              duration: const Duration(
                                seconds: 3,
                              ),
                              animationDuration: const Duration(
                                seconds: 1,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.copy),
                              Text(
                                "Copy",
                                style: GoogleFonts.hind(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(data.quote);
                        },
                        child: Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.share,
                              ),
                              Text(
                                "Share",
                                style: GoogleFonts.hind(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     const Text("Letter Spacing"),
                  //     const Spacer(),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(CupertinoIcons.plus_app_fill),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         editingController.editingModel.letterspacing;
                  //       },
                  //       icon: const Icon(CupertinoIcons.minus_square_fill),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
