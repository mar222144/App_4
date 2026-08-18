import 'package:flutter/material.dart';
import 'package:app_4/widgets/expanses.dart';
import 'package:app_4/models/expense.dart';
class NewExpense extends StatefulWidget {

  const NewExpense({super.key,required this.onAddExpense,});

  final void Function(Expense expense) onAddExpense;
  //final VoidCallback onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
//every text field neets a controller
final _titleController = TextEditingController();  // manage and monitor the textfields

final _amountCountroller = TextEditingController();

DateTime? _selectedDate;
Category _selectedCategory = Category . leisure;

void _presentDatePicker() async{  //calender
  final now = DateTime.now();  //the current date and time

  final firstDate = DateTime(
    now.year - 1,
    now.month,
    now.day,
  );

 final pickedDate= await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: firstDate,
    lastDate: now,
  );
 setState(() {
   _selectedDate = pickedDate;
 });
}

void _submitExpenseData(){
  final enteredAmount =double.tryParse(_amountCountroller.text) ;
  final amountIsInvalid = enteredAmount== null || enteredAmount <=0 ;
  if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null ){
 showDialog(context: context, builder: (ctx) => AlertDialog(
   title: const Text ('Invaled input'),
   content : const Text (' please make sure a valid title , amount , data and category was entered.'),
    actions: [
      TextButton(onPressed:(){
        Navigator.pop(context);
      }, child: Text('Okay'),)
    ],
 ),);

return;

  }


widget.onAddExpense(Expense(title:_titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));



  Navigator.pop(context);
}




@override
  void dispose() {    //clean every single resourse that im not use
  _titleController.dispose();
  _amountCountroller.dispose();
    super.dispose();
  }
  // store the text
 //1 var _enterdTitle = '';
  //2void _saveIitleInput(String inputValue){ //this method take the text and store it in the embty var  _enterdTitle
  //3  _enterdTitle= inputValue;
  //4}
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48 , 16,16),
      child: Column(
        children: [

          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),

        Row(
          children: [
            Expanded(child:

            TextField(
              controller:_amountCountroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '\$ ',
                label: Text('amount'),
              ),
            ),

            )

          ],
        ),

          const SizedBox(width: 16),

         Expanded(child:
         Row(
           mainAxisAlignment: MainAxisAlignment.end ,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
           Text(_selectedDate == null ? 'no date selected' : formatter. format (_selectedDate!) ),
             IconButton(
                 onPressed:  _presentDatePicker,
                 icon: const Icon(
                   Icons.calendar_month,
                 ),
             ),
           ],
         )
         ),

      const SizedBox(height: 16,),

          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                    ),
                  ),
                )
                    .toList(),

                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedCategory = value;
                  });
                }, // <-- CLOSE onChanged here

              ),
            const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),

              ElevatedButton(
                onPressed: _submitExpenseData,

                  //final enteredTitle = _titleController.text;

                 // final enteredAmount =
                  //double.tryParse(_amountCountroller.text);

                 // if (enteredTitle.isEmpty || enteredAmount == null) {
                    //return;


                 // widget.onAddExpense();

                  //Navigator.pop(context);
                //}

                child: const Text('Save Expense'),
              ),
            ],
          )


        ],
      ),



    );
  }
}
