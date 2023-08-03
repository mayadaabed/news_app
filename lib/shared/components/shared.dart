import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import '../../style/colors.dart';

TextStyle textStyle({
  final double fontSize = 20,
  final color = black,
  final FontWeight fontWeight = FontWeight.normal,
}) =>
    GoogleFonts.poppins(
        fontSize: fontSize, color: color, fontWeight: fontWeight);

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChange,
        Function? onTap,
        bool isPassword = false,
        Function? validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        Function? suffixPressed,
        bool isClickable = true,
        bool readOnly = false}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      readOnly: readOnly,
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit(value);
        } else {
          null;
        }
      },
      onChanged: (value) {
        if (onChange != null) {
          onChange(value);
        } else {
          null;
        }
      },
      onTap: () {
        onTap;
      },
      validator: (value) {
        return validate!(value);
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textStyle(color: grey, fontSize: 16),
        prefixIcon: Icon(
          prefix,
          color: grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
        border:
            const OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
        disabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
      ),
    );

Widget buildArticles(
  article,
  context,
) {
  var newDate = '';
  newDate = DateFormat('EEE, d MMM yyyy')
      .format(DateTime.parse(article['publishedAt']));
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: SizedBox(
      height: 120.0,
      child: Card(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
        color: Theme.of(context).cardColor,
        shadowColor: black.withOpacity(0.1),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: '${article['urlToImage']}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.info),
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        '${article['title']}',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    newDate,
                    style: textStyle(color: grey, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget articleBuilder(var list, context, {isSearch = false}) =>
    ConditionalBuilder(
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticles(list[index], context),
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: list.length),
      condition: list.isNotEmpty,
      fallback: (BuildContext context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
