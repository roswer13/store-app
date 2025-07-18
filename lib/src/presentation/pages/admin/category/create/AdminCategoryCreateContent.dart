import 'package:flutter/material.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateBloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';
import 'package:store_app/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:store_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class AdminCategoryCreateContent extends StatelessWidget {
  AdminCategoryCreateBloc? bloc;
  AdminCategoryCreateState state;

  AdminCategoryCreateContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _imageBackground(context),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_imageCategory(context), _cardCategoryForm(context)],
              ),
            ),
          ),
          DefaultIconBack(left: 15, top: 50),
        ],
      ),
    );
  }

  Widget _cardCategoryForm(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            _textNewCategory(),
            _textFieldName(),
            _textFieldDescription(),
            _fabSubmit(),
          ],
        ),
      ),
    );
  }

  Widget _textNewCategory() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 25, left: 15, bottom: 10),
      child: Text(
        'Nueva categoría',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  Widget _textFieldName() {
    return DefaultTextfield(
      label: 'Nombre de la categoría',
      icon: Icons.category,
      onChanged: (text) {
        bloc?.add(AdminCategoryCreateNameChanged(BlocFormItem(value: text)));
      },
      validator: (value) {
        return state.name.error;
      },
      color: Colors.black,
    );
  }

  Widget _textFieldDescription() {
    return DefaultTextfield(
      label: 'Descripción de la categoría',
      icon: Icons.list,
      onChanged: (text) {
        bloc?.add(
          AdminCategoryCreateDescriptionChanged(BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return state.description.error;
      },
      color: Colors.black,
    );
  }

  Widget _fabSubmit() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 30),
      child: FloatingActionButton(
        onPressed: () {
          if (state.formKey!.currentState!.validate()) {
            bloc?.add(AdminCategoryCreateFormSubmitted());
          }
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.check, color: Colors.white),
      ),
    );
  }

  Widget _imageCategory(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context,
          () {
            bloc?.add(AdminCategoryCreatePickImage());
          },
          () {
            bloc?.add(AdminCategoryCreateTakePhoto());
          },
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(top: 150),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipOval(
            child: state.file != null
                ? Image.file(state.file!, fit: BoxFit.cover)
                : Image.asset('assets/img/no-image.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background1.jpg',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}
