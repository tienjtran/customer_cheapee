import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  Column Body() {
    return Column(
      children: <Widget>[
        Container(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: SvgPicture.asset('assets/icons/register.svg'),
            ),
          ),
        ),
        Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                height: 44,
                margin: EdgeInsets.symmetric(vertical: 70, horizontal: 34),
                padding: EdgeInsets.only(left: 18, right: 16, bottom: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.veryLightBlue, width: 1, ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Số điện thoại của bạn",
                    hintStyle: TextStyle(
                      color: AppColors.mediumGrey,
                      fontSize: 12,
                      letterSpacing: 0.50,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Stack(
                children: [
                  Container(
                    height: 44,
                    margin: EdgeInsets.symmetric(vertical: 131, horizontal: 34),
                    padding: EdgeInsets.only(left: 18, right: 16, bottom: 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.veryLightBlue, width: 1, ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Mã OTP",
                        hintStyle: TextStyle(
                          color: AppColors.mediumGrey,
                          fontSize: 12,
                          letterSpacing: 0.50,
                          fontWeight: FontWeight.w300,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    // color: AppColors.red,
                    width: 90,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(260, 145, 0, 0),
                    child: Text(
                      "Gửi mã OTP",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff339ec9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 53,
              margin: EdgeInsets.symmetric(vertical: 201, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3d40bfff), // Màu Shadow
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                color: AppColors.strongGreen,
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SizedBox(
                    width: 311,
                    child: Text(
                      "Tiếp tục",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Đăng ký'),
      centerTitle: true,
    );
  }
}
