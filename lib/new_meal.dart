import 'package:flutter/material.dart';
import '/models/meal.dart';
import 'dummy_data.dart';
import "screens/admin-tab_screen.dart";

class NewMeal extends StatefulWidget {
  static const routeName = '/new-meal-item';
  final Function addNew;

  NewMeal(this.addNew);

  @override
  _NewMeal createState() => _NewMeal();
}

class _NewMeal extends State<NewMeal> {
  final _idController = TextEditingController();
  final _categoryController = TextEditingController();
  final _titleController = TextEditingController();
  final _imageController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _durationController = TextEditingController();
  final _complexityController = TextEditingController();
  final _affordabilityController = TextEditingController();
  final _glutenFreeController = TextEditingController();
  final _lactoseFreeController = TextEditingController();
  final _veganController = TextEditingController();
  final _vegetarianController = TextEditingController();

  void _submitData() {
    final enteredId = _titleController.text;
    final category = _categoryController.text;
    final enteredCategory = category.split(',');
    final enteredTitle = _titleController.text;
    final enteredImage = _imageController.text;
    final ingredients = _ingredientsController.text;
    final enteredIngredients = ingredients.split(',');
    final steps = _stepsController.text;
    final enteredSteps = steps.split(',');
    final enteredDuration = int.parse(_durationController.text);
    final complexity = _complexityController.text;
    final enteredComplexity =
        Complexity.values.firstWhere((e) => e.toString() == complexity);
    final affordability = _affordabilityController.text;
    final enteredAffordability =
        Affordability.values.firstWhere((e) => e.toString() == affordability);
    final enteredGlutenFree = bool.parse(_glutenFreeController.text);
    final enteredLactoseFree = bool.parse(_lactoseFreeController.text);
    final enteredVegan = bool.parse(_veganController.text);
    final enteredVegetarian = bool.parse(_vegetarianController.text);

    if (enteredId.isEmpty ||
        category.isEmpty ||
        enteredTitle.isEmpty ||
        enteredImage.isEmpty ||
        enteredIngredients.isEmpty ||
        enteredSteps.isEmpty ||
        enteredDuration <= 0 ||
        complexity.isEmpty ||
        affordability.isEmpty) {
      return;
    }

    void checkNewMeal() {
      for (int i = 0; i <= DUMMY_MEALS.length; i++) {
        if (enteredId == DUMMY_MEALS[i].id &&
            enteredCategory == DUMMY_MEALS[i].categories &&
            enteredTitle == DUMMY_MEALS[i].title &&
            enteredImage == DUMMY_MEALS[i].imageUrl &&
            enteredIngredients == DUMMY_MEALS[i].ingredients &&
            enteredSteps == DUMMY_MEALS[i].steps &&
            enteredDuration == DUMMY_MEALS[i].duration &&
            enteredComplexity == DUMMY_MEALS[i].complexity &&
            enteredAffordability == DUMMY_MEALS[i].affordability &&
            enteredGlutenFree == DUMMY_MEALS[i].isGlutenFree &&
            enteredLactoseFree == DUMMY_MEALS[i].isLactoseFree &&
            enteredVegan == DUMMY_MEALS[i].isVegan &&
            enteredVegetarian == DUMMY_MEALS[i].isVegetarian) {
          Navigator.of(context).pushReplacementNamed(AdminTabsScreen.routeName);
        }
      }
    }

    widget.addNew(
      enteredId,
      enteredCategory,
      enteredTitle,
      enteredImage,
      enteredIngredients,
      enteredSteps,
      enteredDuration,
      enteredComplexity,
      enteredAffordability,
      enteredGlutenFree,
      enteredLactoseFree,
      enteredVegan,
      enteredVegetarian,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Id', hintText: 'The last id was m10'),
                controller: _idController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Category', hintText: 'c1, c2'),
                controller: _categoryController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Image', hintText: 'Copy the Image URL'),
                controller: _imageController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Ingredients'),
                controller: _ingredientsController,
                onSubmitted: (_) => _submitData(),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Steps'),
                controller: _stepsController,
                onSubmitted: (_) => _submitData(),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Duration'),
                controller: _durationController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Complexity'),
                controller: _complexityController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Affordability'),
                controller: _affordabilityController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Gluten Free'),
                controller: _glutenFreeController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Lactose Free'),
                controller: _lactoseFreeController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Vegan'),
                controller: _veganController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Vegetarian'),
                controller: _vegetarianController,
                onSubmitted: (_) => _submitData(),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Meal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
