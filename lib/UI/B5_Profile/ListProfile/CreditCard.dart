import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/BookingConfirmPage.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/SelectCheckInOutDate.dart';
import 'package:book_it/UI/B1_Home/Hotel/Hotel_Detail_Concept_2/model/BookingRoomList.dart';
import 'package:book_it/UI/B5_Profile/bloc/payment_bloc.dart';
import 'package:book_it/UI/B5_Profile/model/PaymentCardResponse.dart';
import 'package:book_it/UI/Utills/AppColors.dart';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/UI/Utills/custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'BookitCreditCardWidget.dart';
import 'MyCreditCardForm.dart';

class AddCreditCard extends StatefulWidget {
  // String name, password, photoProfile, uid, email;
  //
  // AddCreditCard(
  //     {this.name, this.photoProfile, this.uid, this.email, this.password});
  String hotelID;
  List<String> roomID;
  var checkInDate;
  var checkOutDate;
  List<SelectedRoomList> roomList;
  String amount;
  String phone;
  String specialInstruction;
  String isFor;

  AddCreditCard(
      {this.hotelID,
      this.roomID,
      this.checkInDate,
      this.checkOutDate,
      this.roomList,
      this.amount,
      this.phone,
      this.specialInstruction,
      this.isFor});

  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  String _date = "06/23";

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardID = '';
  String cartType = '';
  String cvvValidationMessage;
  String dateValidationMessage;
  String numberValidationMessage;
  String cardHolderValidationMessage;
  bool isCvvFocused = false;
  PaymentBloc _paymentBloc;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _error;
  AppConstantHelper _appConstantHelper;
  final stripePublishableKeyTest =
      "pk_test_51IiYJTG86vi7NWmjxeCwqBpaNo8YdNBxj2w9IvZRJKcblrArP6HsdYQB7YXqzHqM7uOzEMSIgbiBAIgfdS39Gcxh00oVKuuaU0";

  // final CreditCard testCard = CreditCard(
  //   number: '4000002760003184',
  //   expMonth: 12,
  //   expYear: 22,
  // );

  @override
  void initState() {
    _appConstantHelper = AppConstantHelper();
    _appConstantHelper.setContext(context);
    _paymentBloc = PaymentBloc();
    StripePayment.setOptions(StripeOptions(
        publishableKey: stripePublishableKeyTest,
        merchantId: "Test",
        androidPayMode: 'test'));

    getCardDetailApi();
    // deleteCardApi(context, "card_1IibVwG86vi7NWmj4sDtW7QA");
    super.initState();
  }

  void getCardDetailApi() {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _paymentBloc.getCardDetail(context: context);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppConstantHelper.showDialog(
                  context: context,
                  title: "Network Error",
                  msg: "Please check your internet connection!");
            });
      }
    });
  }

  void addCard(String stripeToken) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _paymentBloc.addCardApi(context: context, stripeToken: stripeToken);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppConstantHelper.showDialog(
                  context: context,
                  title: "Network Error",
                  msg: "Please check your internet connection!");
            });
      }
    });
  }

  void deleteCardApi(BuildContext context, String cardID) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _paymentBloc.deleteCard(context: context, cardID: cardID);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppConstantHelper.showDialog(
                  context: context,
                  title: "Network Error",
                  msg: "Please check your internet connection!");
            });
      }
    });
  }

  void doCreateBookingApiCall({BookingRoomList roomList}) {
    AppConstantHelper.checkConnectivity().then((isConnected) {
      if (isConnected) {
        _paymentBloc.createBooking(context: context, roomList: roomList);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppConstantHelper.showDialog(
                  context: context,
                  title: "Network Error",
                  msg: "Please check your internet connection!");
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Credit Card",
          style: TextStyle(
              fontFamily: "Sofia",),
        ),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 0.0, right: 0.0),
              child: SafeArea(
                child: StreamBuilder<PaymentCardResponse>(
                    initialData: null,
                    stream: _paymentBloc.cardDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data != null &&
                          snapshot.data.data.length > 0) {
                        snapshot.data.data.forEach((element) {
                          if (element.isDeleted == false) {
                            cardNumber = "" + element.cardNumber;
                            print("cardNumber${cardNumber}");
                            cardHolderName = element.cardHolderName;
                            expiryDate = element.expDate;
                            cardID = element.sId;
                            cartType = element.cardType;
                          } else {
                            cardNumber = "";
                            cardHolderName = "";
                            cvvCode = "";
                            cardID = "";
                            cartType = "";
                          }
                        });
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Visibility(
                              visible: snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data != null &&
                                      snapshot.data.data.length > 0
                                  ? false
                                  : true,
                              child: Text(
                                "Enter your credit card details",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.black26,
                                    fontSize: 18.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.0,
                          ),
                          snapshot.hasData &&
                                  snapshot.data != null &&
                                  snapshot.data != null &&
                                  snapshot.data.data.length > 0
                              ? Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    83, 67, 194, 0.14),
                                                blurRadius: 10,
                                                offset: Offset(0, 2)),
                                          ]),
                                      child: SvgPicture.asset(
                                          'assets/image/images/card_bg.svg'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45.0, vertical: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            // assets/images/master_card.svg
                                            child: cartType == 'Visa'
                                                ? Image.asset(
                                                    'assets/image/images/visa.png')
                                                : cartType == 'MasterCard'
                                                    ? SvgPicture.asset(
                                                        'assets/image/images/master_card.svg',
                                                        width: 30,
                                                        height: 30,
                                                      )
                                                    : Image.asset(
                                                        'assets/image/images/visa.png'),
                                            alignment: Alignment.topRight,
                                          ),
                                          Text(
                                            "CARD NUMBER",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: AppColor.primaryColor,
                                                fontSize: 13.0),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                              children: [
                                                Text(
                                                  "XXXX",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontSize: 20.0),
                                                ),
                                                Text(
                                                  "XXXX",
                                                  style: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontSize: 20.0),
                                                  textAlign: TextAlign.end,
                                                ),
                                                Text(
                                                  "XXXX",
                                                  style: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontSize: 20.0),
                                                ),
                                                Text(
                                                  "${cardNumber}",
                                                  style: TextStyle(
                                                      fontFamily: "Sofia",
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.016,
                                          ),
                                          Text(
                                            "Exp Date",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: AppColor.primaryColor,
                                                fontSize: 13.0),
                                          ),
                                          Text(
                                            "${expiryDate}",
                                            style: TextStyle(
                                                fontFamily: "Sofia",
                                                color: AppColor.primaryColor,
                                                fontSize: 18.0),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : BookITCreditCardWidget(
                                  cardNumber: cardNumber,
                                  expiryDate: expiryDate,
                                  cardHolderName: cardHolderName,
                                  cvvCode: cvvCode,
                                  showBackView: isCvvFocused,
                                  cardBgColor: AppColor.primaryColor,
                                ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Visibility(
                              visible: snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data != null &&
                                      snapshot.data.data.length > 0
                                  ? true
                                  : false,
                              child: Center(
                                child: FlatButton(
                                  child: Text(
                                    "Delete Card",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: AppColor.primaryColor,
                                        fontSize: 18.0),
                                  ),
                                  onPressed: () {
                                    if (cardID.isNotEmpty) {
                                      print("cardID ${cardID}");
                                      deleteCardApi(context, cardID.toString());
                                      cardNumber = "";
                                      cardHolderName = "";
                                      cvvCode = "";
                                      cardID = "";
                                      cartType = "";
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: snapshot.hasData &&
                                    snapshot.data != null &&
                                    snapshot.data != null &&
                                    snapshot.data.data.length > 0
                                ? false
                                : true,
                            child: BookItCreditCardForm(
                              formKey: _form,
                              cursorColor: AppColor.primaryColor,
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.redAccent.withOpacity(1),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'Your information is secure and protected',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontFamily: "Sofia",
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                      wordSpacing: 1.0,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      bottom: 20.0,
                                      top: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (snapshot.hasData &&
                                          snapshot.data != null &&
                                          snapshot.data != null &&
                                          snapshot.data.data.length > 0 &&
                                          widget.isFor == "Booking") {
                                        print("hotelID${widget.hotelID}");
                                        print("roomID${widget.roomID}");
                                        print("amount${widget.amount}");
                                        print("phone${widget.phone}");
                                        print(
                                            "specialInstruction${widget.specialInstruction}");

                                        print(
                                            "checkInDate${DateFormat('dd-MM-yyyy').format(widget.checkInDate)}");
                                        print(
                                            "checkOutDate${DateFormat('dd-MM-yyyy').format(widget.checkOutDate)}");

                                        doCreateBookingApiCall(
                                            roomList: BookingRoomList(
                                                hotelID: widget.hotelID,
                                                roomID: widget.roomID,
                                                checkInDate:
                                                    "${DateFormat('dd-MM-yyyy').format(widget.checkInDate)}",
                                                checkOutDate:
                                                    "${DateFormat('dd-MM-yyyy').format(widget.checkOutDate)}",
                                                rooms: widget.roomList,
                                                amount:
                                                    widget.amount.toString(),
                                                phone: widget.phone,
                                                special_instruction:
                                                    widget.specialInstruction));
                                      } else {
                                        print(
                                            "cardHolderNAme${cardHolderName}");
                                        print("cardNumber${cardNumber}");
                                        print("cardExpiry${expiryDate}");
                                        print("cardCVV${cvvCode}");
                                        if (_form.currentState.validate()) {
                                          int month, year;
                                          var split = expiryDate
                                              .split(new RegExp(r'(\/)'));
                                          // The value before the slash is the month while the value to right of
                                          // it is the year.
                                          month = int.parse(split[0]);
                                          year = int.parse(split[1]);
                                          print("month${month}");
                                          print("month${year}");
                                          _paymentBloc.progressSink.add(true);
                                          StripePayment.createTokenWithCard(
                                            CreditCard(
                                                name: cardHolderName,
                                                number: cardNumber,
                                                cvc: cvvCode,
                                                expMonth: month,
                                                expYear: year),
                                          ).then((token) {
                                            print('Received ${token.tokenId}');
                                            addCard(token.tokenId);
                                          }).catchError(setError);
                                        }

                                        // addData();
                                        // Navigator.of(context).push(PageRouteBuilder(
                                        //     pageBuilder: (_, __, ___) => new BookingConfirmPage(),
                                        //     transitionDuration: Duration(milliseconds: 600),
                                        //     transitionsBuilder: (_, Animation<double> animation,
                                        //         __, Widget child) {
                                        //       return Opacity(
                                        //         opacity: animation.value,
                                        //         child: child,
                                        //       );
                                        //     }));

                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 100),
                                      height: 53.0,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          snapshot.hasData &&
                                                  snapshot.data != null &&
                                                  snapshot.data != null &&
                                                  snapshot.data.data.length > 0
                                              ? "Continue"
                                              : "Add Credit Card",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Sofia",
                                              fontSize: 19.0),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: AppColor.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          )
                        ],
                      );
                    }),
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: _paymentBloc.progressStream,
            builder: (context, snapshot) {
              return Center(
                  child: CommmonProgressIndicator(
                      snapshot.hasData ? snapshot.data : false));
            },
          )
        ],
      ),
    );
  }

  bool validate(BuildContext context) {
    if (cardNumber.isEmpty) {
      showErrorDialog(
          context, "Card Validate Error", "Please input Card Number");
      return false;
    } else if (expiryDate.isEmpty) {
      showErrorDialog(
          context, "Card Validate Error", "Please input Card Expiry Date");
      return false;
    } else if (cvvCode.isEmpty) {
      showErrorDialog(context, "Card Validate Error", "Please input Card CVV");
      return false;
    } else if (cardHolderName.isEmpty) {
      showErrorDialog(
          context, "Card Validate Error", "Please input Card Holder Name");
      return false;
    }
    return true;
  }

  void setError(dynamic error) {
    // Utils.showErrorSnackBar(message: error.toString(), context: context);
    setState(() {
      _paymentBloc.progressSink.add(false);
      _error = error.toString();
      print(_error);
      showErrorDialog(context, "Error", "${_error.split(",")[1]}");
    });
  }

  void showErrorDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppConstantHelper.showDialog(
              context: context, title: title, msg: msg);
        });
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
