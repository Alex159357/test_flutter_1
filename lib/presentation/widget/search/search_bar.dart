import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  final bool editable;
  final Function(String value)? onChanged;
  final VoidCallback? onBackClicked;
  final String initialValue;

  const SearchBar(
      {Key? key, this.editable = false, this.initialValue = "", this.onChanged, this.onBackClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(21)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: editable
                  ? TextFormField(
                      onChanged: onChanged,
                      initialValue: initialValue,
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: GestureDetector(
                          onTap: onBackClicked,
                          child: const Icon(Icons.arrow_back),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 10),
                      ),
                    )
                  : Container()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
            child: SvgPicture.asset("assets/icons/search_icon.svg"),
          )
        ],
      ),
    );
  }
}
