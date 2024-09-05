import 'dart:developer';

import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:ayurveda/data/entities/treatment_entity.dart';
import 'package:ayurveda/presentation/provider/patient_provider.dart';
import 'package:ayurveda/presentation/provider/registration_provider.dart';
import 'package:ayurveda/presentation/widgets/app_space_widget.dart';
import 'package:ayurveda/presentation/widgets/input_decoration_widget.dart';
import 'package:ayurveda/presentation/widgets/notification_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart'
    show
        FilteringTextInputFormatter,
        LengthLimitingTextInputFormatter,
        rootBundle;
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              centerTitle: true,
              surfaceTintColor: AppColors.white,
              title: Text(
                'Register',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: const [
                NotificationIconWidget(),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWidget(
                      title: 'Name',
                    ),
                    setHeight(8),
                    TextFormField(
                      controller:
                          context.watch<RegistrationProvider>().nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 3) {
                          return 'Name should be atleast 3 characters';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        context,
                        hintText: 'Enter your full name',
                      ),
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Whatsapp Number',
                    ),
                    setHeight(8),
                    TextFormField(
                      controller: context
                          .watch<RegistrationProvider>()
                          .whatsappController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your whatsapp number';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid whatsapp number';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: inputDecoration(
                        context,
                        hintText: 'Enter your whatsapp number',
                      ),
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Address',
                    ),
                    setHeight(8),
                    TextFormField(
                      controller: context
                          .watch<RegistrationProvider>()
                          .addressController,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your address';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid address';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        context,
                        hintText: 'Enter your full address',
                      ),
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Location',
                    ),
                    setHeight(8),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return DropdownMenu(
                          controller: snapshot.districtController,
                          width: MediaQuery.of(context).size.width - 32,
                          menuHeight: 250,
                          hintText: 'Choose your Location',
                          selectedTrailingIcon: Icon(
                            CupertinoIcons.chevron_up,
                            color: AppColors.primaryColor,
                          ),
                          trailingIcon: Icon(
                            CupertinoIcons.chevron_down,
                            color: AppColors.primaryColor,
                          ),
                          dropdownMenuEntries: List.generate(
                            snapshot.keralaDistricts.length,
                            (index) => DropdownMenuEntry(
                              label: snapshot.keralaDistricts[index],
                              value: index + 1,
                            ),
                          ),
                          inputDecorationTheme: dropDownDecoration(),
                          menuStyle: MenuStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.white),
                          ),
                        );
                      },
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Branch',
                    ),
                    setHeight(8),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return DropdownMenu(
                          onSelected: (value) {
                            if (value != null) {
                              snapshot.setBranchId = value;
                            }
                          },
                          controller: snapshot.branchController,
                          width: MediaQuery.of(context).size.width - 32,
                          menuHeight: 250,
                          hintText: 'Select the branch',
                          selectedTrailingIcon: Icon(
                            CupertinoIcons.chevron_up,
                            color: AppColors.primaryColor,
                          ),
                          trailingIcon: Icon(
                            CupertinoIcons.chevron_down,
                            color: AppColors.primaryColor,
                          ),
                          dropdownMenuEntries: List.generate(
                            snapshot.branches.length,
                            (index) => DropdownMenuEntry(
                              label: '${snapshot.branches[index].name}',
                              value: snapshot.branches[index].id,
                            ),
                          ),
                          inputDecorationTheme: dropDownDecoration(),
                          menuStyle: MenuStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.white),
                          ),
                        );
                      },
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Teatments',
                    ),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return Column(
                          children: List.generate(
                            snapshot.selectedTreatments.length,
                            (index) => Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  setWidth(8),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                snapshot
                                                    .selectedTreatments[index]
                                                    .name,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                            setWidth(16),
                                            GestureDetector(
                                              onTap: () {
                                                snapshot.removeFromSelectedTreatments =
                                                    snapshot.selectedTreatments[
                                                        index];
                                              },
                                              child: Icon(
                                                CupertinoIcons
                                                    .xmark_circle_fill,
                                                color: AppColors.closeButton,
                                              ),
                                            ),
                                          ],
                                        ),
                                        setHeight(8),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Male",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                  ),
                                                  setWidth(8),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors
                                                            .borderColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "${snapshot.selectedTreatments[index].maleCount}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            setWidth(16),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Female",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                  ),
                                                  setWidth(8),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors
                                                            .borderColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "${snapshot.selectedTreatments[index].femaleCount}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            setWidth(16),
                                            GestureDetector(
                                              onTap: () {
                                                addOrEditTreatment(
                                                  context,
                                                  snapshot,
                                                  snapshot.selectedTreatments[
                                                      index],
                                                );
                                              },
                                              child: Image.asset(
                                                'assets/icons/Vector.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    setHeight(16),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.black,
                            backgroundColor: AppColors.lightGreen,
                          ),
                          onPressed: () {
                            addOrEditTreatment(context, snapshot, null);
                          },
                          child: const Text('+ Add Treatments'),
                        );
                      },
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Total Amount',
                    ),
                    setHeight(8),
                    TextFormField(
                      readOnly: true,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<RegistrationProvider>()
                              .calculateBalance();
                        }
                      },
                      controller: context
                          .watch<RegistrationProvider>()
                          .totalAmountController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the total amount';
                        }
                        if (value.length < 3) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: inputDecoration(
                        context,
                        hintText: 'Enter the total amount',
                      ),
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Discount Amount',
                    ),
                    setHeight(8),
                    TextFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<RegistrationProvider>()
                              .calculateBalance();
                        }
                      },
                      controller: context
                          .watch<RegistrationProvider>()
                          .discountController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: inputDecoration(
                        context,
                        hintText: 'Enter the discount amount',
                      ),
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Payment Option',
                    ),
                    setHeight(8),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            snapshot.paymentTypes.length,
                            (index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Radio(
                                  activeColor: AppColors.primaryColor,
                                  value: snapshot.paymentTypes[index],
                                  groupValue: snapshot.paymentType,
                                  onChanged: (value) {
                                    if (value != null) {
                                      snapshot.paymentType = value;
                                    }
                                  },
                                ),
                                Text(
                                  snapshot.paymentTypes[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Advance Amount',
                    ),
                    setHeight(8),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            context
                                .read<RegistrationProvider>()
                                .calculateBalance();
                          },
                          controller: snapshot.advanceController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: inputDecoration(
                            context,
                            hintText: 'Enter the advance amount',
                          ),
                        );
                      },
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Balance Amount',
                    ),
                    setHeight(8),
                    TextFormField(
                      readOnly: true,
                      controller: context
                          .watch<RegistrationProvider>()
                          .balanceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: inputDecoration(
                        context,
                        hintText: 'Enter the balance amount',
                      ),
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Treatment Date',
                    ),
                    setHeight(8),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return TextFormField(
                          controller: snapshot.treatmentDate,
                          readOnly: true,
                          onTap: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: snapshot.selectedTreatmentDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            ).then((value) {
                              if (value != null) {
                                snapshot.changeDateSelection = value;
                              }
                            });
                          },
                          decoration: inputDecoration(
                            context,
                            hintText: 'Select the treatment date',
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: SvgPicture.asset(
                                'assets/icons/uil--calender.svg',
                                // ignore: deprecated_member_use
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    setHeight(16),
                    const TitleWidget(
                      title: 'Treatment Time',
                    ),
                    setHeight(8),
                    Consumer<RegistrationProvider>(
                      builder: (context, snapshot, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: snapshot.selectedTime.hourOfPeriod
                                      .toString(),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  await showTimePicker(
                                    context: context,
                                    initialTime: snapshot.selectedTime,
                                  ).then((value) {
                                    if (value != null) {
                                      snapshot.changeTimeSelection = value;
                                    }
                                  });
                                },
                                decoration: inputDecoration(
                                  context,
                                  hintText: 'Hour',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.chevron_down,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            setWidth(16),
                            Expanded(
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: '${snapshot.selectedTime.minute}',
                                ),
                                readOnly: true,
                                onTap: () async {
                                  await showTimePicker(
                                    context: context,
                                    initialTime: snapshot.selectedTime,
                                  ).then((value) {
                                    if (value != null) {
                                      snapshot.changeTimeSelection = value;
                                    }
                                  });
                                },
                                decoration: inputDecoration(
                                  context,
                                  hintText: 'Minute',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.chevron_down,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            setWidth(16),
                            Text(
                              snapshot.selectedTime.period.name.toUpperCase(),
                            ),
                          ],
                        );
                      },
                    ),
                    setHeight(64),
                    Consumer2<RegistrationProvider, PatientProvider>(
                      builder: (context, state, patient, _) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (state.selectedTreatments.isEmpty) {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Please select atleast one treatment",
                                      ),
                                    ),
                                  );
                              } else {
                                await state.saveRegistration().then((value) {
                                  if (state.isSuccess) {
                                    log("Success: ready");
                                    state.isLoading = true;
                                    patient.fetchPatients().then((value) async {
                                      state.isLoading = false;
                                      state.isSuccess = false;
                                      if(context.mounted){
                                        await showGeneralDialog(
                                        context: context,
                                        pageBuilder: (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) {
                                          return PopScope(
                                            canPop: false,
                                            child: Scaffold(
                                              appBar: AppBar(
                                                leading: IconButton(
                                                  onPressed: () {
                                                    kNavigationKey.currentState
                                                        ?.pop();
                                                    kNavigationKey.currentState
                                                        ?.pushNamedAndRemoveUntil(
                                                      '/home',
                                                      (route) => false,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    CupertinoIcons.back,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                actions: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await Share.shareXFiles(
                                                        [
                                                          await _createPdf(
                                                            provider: state,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons.share,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              body: FutureBuilder(
                                                future:
                                                    _createPdf(provider: state),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return PDFView(
                                                      filePath:
                                                          snapshot.data?.path,
                                                      autoSpacing: true,
                                                      enableSwipe: true,
                                                      pageSnap: true,
                                                      swipeHorizontal: true,
                                                      nightMode: false,
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                      child: Text(
                                                        'Error: ${snapshot.error}',
                                                      ),
                                                    );
                                                  }
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      }
                                    });
                                  }
                                });
                              }
                            }
                          },
                          child: state.isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : const Text('Save'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<XFile> _createPdf({required RegistrationProvider provider}) async {
    final pdf = pw.Document();
    final imageBytes = await rootBundle.load('assets/images/logo_large.png');
    final imageBytesHeader =
        await rootBundle.load('assets/images/logo_small.png');
    final imageBytesSign = await rootBundle.load('assets/images/sign.png');

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Center(
          child: pw.Stack(
            children: <pw.Widget>[
              // pw.Text('Hello World', style: const pw.TextStyle(fontSize: 40)),
              pw.Padding(
                padding: const pw.EdgeInsets.all(16),
                child: pw.Center(
                  child: pw.Opacity(
                    opacity: 0.05,
                    child: pw.Image(
                      pw.MemoryImage(imageBytes.buffer.asUint8List()),
                    ),
                  ),
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Header(
                    padding: const pw.EdgeInsets.only(bottom: 16),
                    child: pw.Row(
                      children: [
                        pw.Image(
                          pw.MemoryImage(imageBytesHeader.buffer.asUint8List()),
                        ),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                'KUMARAKOM',
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563',
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.grey,
                                ),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'e-mail: unknown@gmail.com',
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.grey,
                                ),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'Mob: +91 9876543210 | +91 9786543210',
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.grey,
                                ),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'Mob: +91 9876543210 | +91 9786543210',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.grey,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'GST No: 32AABCU9603R1ZW',
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Patient Deatails',
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.green300,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Name: ',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    provider.nameController.text,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Booked On',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    DateFormat("dd/MM/yyyy | hh:mm a")
                                        .format(DateTime.now()),
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Address: ',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    "${provider.addressController.text}, ${provider.districtController.text}",
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Treatment Date',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    provider.treatmentDate.text,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Whatsapp Number',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    "+91 ${provider.whatsappController.text}",
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Booked On',
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    DateFormat("dd/MM/yyyy | hh:mm a")
                                        .format(DateTime.now()),
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                    ],
                  ),
                  pw.Divider(
                    thickness: 0.5,
                    color: PdfColors.grey,
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Treatment',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.green300,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Price',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.green300,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Male',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.green300,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Female',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.green300,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Total',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.green300,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  ...provider.selectedTreatments.map(
                    (e) => pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 8),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                              e.name,
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              e.price,
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              e.maleCount.toString(),
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              e.femaleCount.toString(),
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              e.price.toString(),
                              style: const pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Divider(
                    thickness: 0.5,
                    color: PdfColors.grey,
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Total Amount',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            provider.totalAmountController.text,
                            style: const pw.TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Discount',
                          style: const pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            provider.discountController.text,
                            style: const pw.TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Advance',
                          style: const pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            provider.advanceController.text,
                            style: const pw.TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Divider(
                    indent: 280,
                    thickness: 0.5,
                    color: PdfColors.grey,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Balance',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            provider.balanceController.text,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 48),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Thank you for choosing us',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.green300,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Your well-being is our commitment, and we\'re honored\nyou\'ve entrusted us with your health journey',
                        textAlign: pw.TextAlign.end,
                        style: const pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.grey,
                        ),
                      ),
                      pw.SizedBox(height: 16),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 32),
                        child: pw.Image(
                          width: 110,
                          pw.MemoryImage(imageBytesSign.buffer.asUint8List()),
                        ),
                      ),
                    ],
                  ),
                  pw.Spacer(),
                  pw.Align(
                    alignment: pw.Alignment.bottomCenter,
                    child: pw.Column(
                      children: [
                        pw.Divider(
                          thickness: 0.5,
                          color: PdfColors.grey,
                        ),
                        pw.Footer(
                          title: pw.Text(
                            'Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment',
                            style: const pw.TextStyle(
                              color: PdfColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
      "${output.path}/invoice-${DateFormat("dd-MM-yyyy-hh-mm-a").format(DateTime.now())}.pdf",
    );
    await file.writeAsBytes(await pdf.save());
    return XFile(file.path);
  }

  Future<dynamic> addOrEditTreatment(
    BuildContext context,
    RegistrationProvider snapshot,
    TreatmentEntity? entity,
  ) {
    return showDialog(
      context: context,
      routeSettings: RouteSettings(
        arguments: snapshot,
      ),
      builder: (context) {
        if (entity != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            snapshot.setMaleCount = entity.maleCount;
            snapshot.setFemaleCount = entity.femaleCount;
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            snapshot.setMaleCount = 0;
            snapshot.setFemaleCount = 0;
          });
        }
        final provider =
            ModalRoute.of(context)!.settings.arguments as RegistrationProvider;
        return ListenableProvider(
          create: (context) => provider,
          child: Consumer<RegistrationProvider>(
            builder: (context, snapshot, _) {
              final data = (entity != null)
                  ? snapshot.treatments
                      .where((element) => element.id == entity.id)
                      .toList()
                  : null;

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                surfaceTintColor: AppColors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWidget(
                      title: 'Choose Treatment',
                    ),
                    setHeight(8),
                    DropdownMenu(
                      menuHeight: 250,
                      initialSelection: data != null ? data[0] : null,
                      width: MediaQuery.of(context).size.width - 150,
                      hintText: 'Choose prefered treatment',
                      selectedTrailingIcon: Icon(
                        CupertinoIcons.chevron_up,
                        color: AppColors.primaryColor,
                      ),
                      trailingIcon: Icon(
                        CupertinoIcons.chevron_down,
                        color: AppColors.primaryColor,
                      ),
                      onSelected: (value) {
                        if (value != null) {
                          snapshot.selectedTreatment = value;
                        }
                      },
                      dropdownMenuEntries: List.generate(
                        snapshot.treatments.length,
                        (index) => DropdownMenuEntry(
                          label: '${snapshot.treatments[index].name}',
                          value: snapshot.treatments[index],
                        ),
                      ),
                      inputDecorationTheme: dropDownDecoration(),
                      menuStyle: MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.white,
                        ),
                      ),
                    ),
                    setHeight(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.fillColor,
                              border: Border.all(
                                color: AppColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: const Text("Male"),
                          ),
                        ),
                        setWidth(16),
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  snapshot.decrementMaleCount();
                                },
                                child: FittedBox(
                                  child: Icon(
                                    CupertinoIcons.minus_circle_fill,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              setWidth(8),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${snapshot.maleCount}",
                                    ),
                                  ),
                                ),
                              ),
                              setWidth(8),
                              GestureDetector(
                                onTap: () {
                                  snapshot.incrementMaleCount();
                                },
                                child: FittedBox(
                                  child: Icon(
                                    CupertinoIcons.plus_circle_fill,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    setHeight(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.fillColor,
                              border: Border.all(
                                color: AppColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: const Text("Female"),
                          ),
                        ),
                        setWidth(16),
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  snapshot.decrementFemaleCount();
                                },
                                child: FittedBox(
                                  child: Icon(
                                    CupertinoIcons.minus_circle_fill,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              setWidth(8),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${snapshot.femaleCount}",
                                    ),
                                  ),
                                ),
                              ),
                              setWidth(8),
                              GestureDetector(
                                onTap: () {
                                  snapshot.incrementFemaleCount();
                                },
                                child: FittedBox(
                                  child: Icon(
                                    CupertinoIcons.plus_circle_fill,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    setHeight(32),
                    ElevatedButton(
                      onPressed: ((snapshot.femaleCount > 0 ||
                                  snapshot.maleCount > 0) &&
                              snapshot.selectedTreatmentDropDown != null)
                          ? () {
                              snapshot.addToSelectedTreatments();
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w100),
      ),
    );
  }
}
