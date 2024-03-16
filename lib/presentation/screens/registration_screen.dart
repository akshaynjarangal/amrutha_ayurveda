import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:ayurveda/presentation/widgets/app_space_widget.dart';
import 'package:ayurveda/presentation/widgets/input_decoration_widget.dart';
import 'package:ayurveda/presentation/widgets/notification_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                  DropdownMenu(
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
                      5,
                      (index) => DropdownMenuEntry(
                        label: 'Location $index',
                        value: index,
                      ),
                    ),
                    inputDecorationTheme: dropDownDecoration(),
                    menuStyle: MenuStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.white),
                    ),
                  ),
                  setHeight(16),
                  const TitleWidget(
                    title: 'Branch',
                  ),
                  setHeight(8),
                  DropdownMenu(
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
                  setHeight(16),
                  const TitleWidget(
                    title: 'Teatments',
                  ),
                  Column(
                    children: List.generate(
                      3,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Couple Combo Packege (Unani treatment hello)",
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
                                        onTap: () {},
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
                                                    fontWeight: FontWeight.w100,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            setWidth(8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.borderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "2",
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
                                                    fontWeight: FontWeight.w100,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            setWidth(8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.borderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "2",
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
                                        onTap: () {},
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
                  ),
                  setHeight(16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.black,
                      backgroundColor: AppColors.lightGreen,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
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
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  hintText: 'Choose prefered treatment',
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
                                      label: 'Location $index',
                                      value: index,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text("Male"),
                                      ),
                                    ),
                                    setWidth(16),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          GestureDetector(
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Center(child: Text("1")),
                                            ),
                                          ),
                                          setWidth(8),
                                          GestureDetector(
                                            onTap: (){},
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text("Female"),
                                      ),
                                    ),
                                    setWidth(16),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          GestureDetector(
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Center(child: Text("1")),
                                            ),
                                          ),
                                          setWidth(8),
                                          GestureDetector(
                                            onTap: (){},
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
                                  onPressed: () {},
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('+ Add Treatments'),
                  ),
                  setHeight(16),
                  const TitleWidget(
                    title: 'Total Amount',
                  ),
                  setHeight(8),
                  TextFormField(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => Row(
                        children: [
                          Radio(
                            activeColor: AppColors.primaryColor,
                            value: index,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                          Text(
                            index == 0
                                ? 'Cash'
                                : index == 1
                                    ? 'Card'
                                    : 'UPI',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ),
                  ),
                  setHeight(16),
                  const TitleWidget(
                    title: 'Advance Amount',
                  ),
                  setHeight(8),
                  TextFormField(
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
