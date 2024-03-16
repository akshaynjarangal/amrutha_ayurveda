import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:ayurveda/data/entities/treatment_entity.dart';
import 'package:ayurveda/presentation/provider/registration_provider.dart';
import 'package:ayurveda/presentation/widgets/app_space_widget.dart';
import 'package:ayurveda/presentation/widgets/input_decoration_widget.dart';
import 'package:ayurveda/presentation/widgets/notification_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                      hintText: 'Enter your full name',
                    ),
                  ),
                  setHeight(16),
                  const TitleWidget(
                    title: 'Address',
                  ),
                  setHeight(8),
                  TextFormField(
                    controller:
                        context.watch<RegistrationProvider>().addressController,
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
                              MaterialStatePropertyAll(AppColors.white),
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
                              MaterialStatePropertyAll(AppColors.white),
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
                                              snapshot.selectedTreatments[index]
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
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
                                              CupertinoIcons.xmark_circle_fill,
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
                                                      color:
                                                          AppColors.borderColor,
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
                                                      color:
                                                          AppColors.borderColor,
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
                                                snapshot
                                                    .selectedTreatments[index],
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
                            children: [
                              Radio(
                                activeColor: AppColors.primaryColor,
                                value: snapshot.paymentTypes[index],
                                groupValue: snapshot.paymentType,
                                onChanged: (value) {},
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
                  TextFormField(
                    controller: context
                        .watch<RegistrationProvider>()
                        .advanceController,
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
                  TextFormField(
                    readOnly: true,
                    onTap: (){
                      showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now());
                    },
                    decoration: inputDecoration(
                      context,
                      hintText: 'Select the treatment date',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset(
                          'assets/icons/uil--calender.svg',
                          // ignore: deprecated_member_use
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  setHeight(16),
                  const TitleWidget(
                    title: 'Treatment Time',
                  ),
                  setHeight(8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownMenu(
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
                            5,
                            (index) => DropdownMenuEntry(
                              label: 'Branch $index',
                              value: index,
                            ),
                          ),
                          inputDecorationTheme: dropDownDecoration(),
                          menuStyle: MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.white),
                          ),
                        ),
                      ),
                      setWidth(16),
                      Expanded(
                        child: DropdownMenu(
                          menuHeight: 250,
                          hintText: 'Select the branch',
                          textStyle: TextStyle(color: AppColors.black),
                          selectedTrailingIcon: Icon(
                            CupertinoIcons.chevron_up,
                            color: AppColors.primaryColor,
                          ),
                          trailingIcon: Icon(
                            CupertinoIcons.chevron_down,
                            color: AppColors.primaryColor,
                          ),
                          dropdownMenuEntries: List.generate(
                            5,
                            (index) => DropdownMenuEntry(
                              label: 'Branch $index',
                              value: index,
                            ),
                          ),
                          inputDecorationTheme: dropDownDecoration(),
                          menuStyle: MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  setHeight(64),
                  ElevatedButton(onPressed: () {}, child: const Text('Save')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
                        backgroundColor: MaterialStatePropertyAll(
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
