import 'package:flutter/material.dart';

void main() {
  runApp(const SmartNoteApp());
}

class SmartNoteApp extends StatelessWidget {
  const SmartNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to SK Smart Note App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const CustomerListScreen(),
    );
  }
}

class Transaction {
  final String details;      
  final double totalAmount;  
  final double cashPaid;    
  final double netDue;     
  final String buyDate;    
  final String payDate;    

  Transaction({
    required this.details,
    required this.totalAmount,
    required this.cashPaid,
    required this.netDue,
    required this.buyDate,
    required this.payDate,
  });
}

class Customer {
  final String id;
  final String name;
  final String phone;
  final String dueDate; 
  double dueAmount;
  List<Transaction> history;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.dueDate,
    required this.dueAmount,
    required this.history,
  });
}

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  String _myShopName = 'বিসমিল্লাহ স্টোর'; 
  final _shopNameController = TextEditingController(text: 'বিসমিল্লাহ স্টোর');
  String _robotVoiceType = 'female'; 

  final List<Customer> _customers = [
    Customer(
      id: 'SK-2026-01', 
      name: 'মো: রহিম মিয়া (আজ ১ম দিন)', 
      phone: '01700000000', 
      dueDate: '30/05/2026', 
      dueAmount: 5500, 
      history: [Transaction(details: 'বাকি সওদা', totalAmount: 5500, cashPaid: 0, netDue: 5500, buyDate: '২০/০৫/২০২৬', payDate: '৩০/০৫/২০২৬')],
    ),
    Customer(
      id: 'SK-2026-02', 
      name: 'আব্দুল করিম (আজ ২য় দিন)', 
      phone: '01800000000', 
      dueDate: '29/05/2026', 
      dueAmount: 3200, 
      history: [Transaction(details: 'চালের বস্তা', totalAmount: 3200, cashPaid: 0, netDue: 3200, buyDate: '১৫/০৫/২০২৬', payDate: '২৯/০৫/২০২৬')],
    ),
    Customer(
      id: 'SK-2026-03', 
      name: 'সোহেল রানা (৩+ দিন পার)', 
      phone: '01900000000', 
      dueDate: '25/05/2026', 
      dueAmount: 7800, 
      history: [Transaction(details: 'তেল ও ডাল', totalAmount: 7800, cashPaid: 0, netDue: 7800, buyDate: '১০/০৫/২০২৬', payDate: '২৫/০৫/২০২৬')],
    ),
  ];

  Map<String, Map<String, String>> _checkRobotVoiceCallingStatus() {
    Map<String, Map<String, String>> currentActions = {};
    DateTime testToday = DateTime(2026, 05, 31); 

    for (var customer in _customers) {
      if (customer.dueAmount > 0) {
        try {
          List<String> parts = customer.dueDate.split('/');
          if (parts.length == 3) {
            DateTime dueDateTime = DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            );

            int daysOverdue = testToday.difference(dueDateTime).inDays;

            if (daysOverdue > 0) {
              String voiceScript = '';
              String alertMessage = '';

              if (daysOverdue == 1) {
                alertMessage = 'কল স্ট্যাটাস: ১ম দিনের নরম রিমাইন্ডার দেওয়া হচ্ছে।';
                if (_robotVoiceType == 'female') {
                  voiceScript = 'মেয়ের কন্ঠে: আসসালামু আলাইকুম, আমি $_myShopName থেকে বলছি। সম্মানিত গ্রাহক ${customer.name}, আপনার অবগতির জন্য জানানো যাচ্ছে যে, আমাদের দোকানে আপনার কিছু বকেয়া হিসাব রয়েছে, যা পরিশোধের নির্ধারিত তারিখ গতকাল পার হয়ে গেছে। বকেয়া টাকাটি পরিশোধ করার জন্য আপনাকে বিনীত অনুরোধ করছি। ধন্যবাদ।';
                } else {
                  voiceScript = 'ছেলের কন্ঠে: আসসালামু আলাইকুম, আমি $_myShopName থেকে বিনীতভাবে বলছি। সম্মানিত গ্রাহক ${customer.name}, আমাদের দোকানে আপনার পূর্বের বকেয়া হিসাবটি পরিশোধের শেষ তারিখ গতকাল পার হয়ে গেছে। অনুগ্রহ করে বকেয়া টাকাটি পরিশোধ করে সহযোগিতা করুন। ধন্যবাদ।';
                }
              } 
              else if (daysOverdue == 2) {
                alertMessage = 'সতর্কবার্তা: ২য় দিনের কড়া কল দেওয়া হচ্ছে!';
                if (_robotVoiceType == 'female') {
                  voiceScript = 'মেয়ের কন্ঠে (গম্ভীর): হ্যালো আসসালামু আলাইকুম, আমি $_myShopName থেকে বলছি। কাস্টমার ${customer.name}, আপনার বকেয়া ${customer.dueAmount.toStringAsFixed(0)} টাকা পরিশোধের তারিখ ২ দিন আগেই পার হয়ে গেছে। আজই দোকানে এসে আপনার বাকি টাকাটি পরিষ্কার করার জন্য বলা হচ্ছে।';
                } else {
                  voiceScript = 'ছেলের কন্ঠে (গম্ভীর): হ্যালো, আমি $_myShopName থেকে বলছি। গ্রাহক ${customer.name}, আপনার বকেয়া টাকা পরিশোধের শেষ সময় দুই দিন আগেই অতিবাহিত হয়েছে। অনুগ্রহ করে আজকের মধ্যে দোকানে এসে আপনার বকেয়া হিসাবটি বুঝিয়ে দিন।';
                }
              } 
              else {
                alertMessage = 'চূড়ান্ত নোটিশ: ৩ দিনের বেশি পার হওয়ায় তীব্র কড়া কল!';
                if (_robotVoiceType == 'female') {
                  voiceScript = 'মেয়ের কন্ঠে (রাগী): হ্যালো ${customer.name}, আমি $_myShopName থেকে বলছি। আপনার বকেয়া টাকা পরিশোধের ডেট অনেক দিন আগে পার হয়ে গেছে। আপনি ফোন অবহেলা করছেন। আগামী ২৪ ঘণ্টার মধ্যে দোকানে এসে যোগাযোগ না করলে আমরা আপনার বিরুদ্ধে কঠোর ব্যবস্থা নিতে বাধ্য হব।';
                } else {
                  voiceScript = 'ছেলের কন্ঠে (রাগী): সাবধান, আমি $_myShopName থেকে বলছি। কাস্টমার ${customer.name}, বেশ কয়েকদিন পার হয়ে গেলেও আপনার বকেয়া পরিশোধের কোনো লক্ষণ নেই। এই কলটিকে চূড়ান্ত নোটিশ হিসেবে গণ্য করুন এবং অবিলম্বে দোকানে এসে বকেয়া শোধ করুন।';
                }
              }

              currentActions[customer.id] = {
                'status': 'calling',
                'msg': alertMessage,
                'voice': voiceScript
              };
            }
          }
        } catch (e) {
          // স্কিপ
        }
      } else {
        currentActions[customer.id] = {
          'status': 'stopped',
          'msg': 'বাকি পরিশোধিত! রোবট কল সিস্টেম বন্ধ।',
          'voice': 'রোবট এখন শান্ত।'
        };
      }
    }
    return currentActions;
  }

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('নতুন কাস্টমার আইডি তৈরি', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'কাস্টমারের নাম', prefixIcon: Icon(Icons.person))),
              TextField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'মোবাইল নম্বর', prefixIcon: Icon(Icons.phone))),
              TextField(controller: _dateController, decoration: const InputDecoration(labelText: 'পরিশোধের শেষ তারিখ (দিন/মাস/বছর)', hintText: '৩০/০৬/২০২৬', prefixIcon: Icon(Icons.calendar_month))),
              TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'শুরুতে বকেয়া টাকা', prefixIcon: Icon(Icons.money))),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('বাতিল')),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
                setState(() {
                  int nextIdNumber = _customers.length + 1;
                  String generatedId = 'SK-2026-${nextIdNumber.toString().padLeft(2, '0')}';
                  double initialAmount = double.tryParse(_amountController.text) ?? 0.0;
                  String targetDate = _dateController.text.isEmpty ? '৩০/০৬/২০২৬' : _dateController.text;
                  
                  _customers.add(Customer(
                    id: generatedId,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    dueDate: targetDate,
                    dueAmount: initialAmount,
                    history: initialAmount > 0 
                      ? [Transaction(details: 'শুরুর বকেয়া ব্যালেন্স', totalAmount: initialAmount, cashPaid: 0, netDue: initialAmount, buyDate: '৩১/০৫/২০২৬', payDate: targetDate)]
                      : [],
                  ));
                });
                _nameController.clear(); _phoneController.clear(); _dateController.clear(); _amountController.clear();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('আইডি তৈরি করুন', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, String>> robotVoiceData = _checkRobotVoiceCallingStatus();

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome to SK Smart Note App', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.storefront, color: Colors.blue, size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _shopNameController,
                          decoration: const InputDecoration(
                            labelText: 'আপনার দোকানের নাম লিখুন',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                          onChanged: (value) {
                            setState(() {
                              _myShopName = value.isEmpty ? 'আমাদের দোকান' : value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
        
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.record_voice_over, color: Colors.purple, size: 20),
                          SizedBox(width: 6),
                          Text('রোবট ভয়েস কন্ট্রোল:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.purple)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      RadioListTile<String>(
                        title: const Text('মেয়ের কন্ঠে (Female)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        value: 'female',
                        groupValue: _robotVoiceType,
                        activeColor: Colors.purple,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) {
                          setState(() {
                            _robotVoiceType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('ছেলের কন্ঠে (Male)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        value: 'male',
                        groupValue: _robotVoiceType,
                        activeColor: Colors.purple,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) {
                          setState(() {
                            _robotVoiceType = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
        
                const Text('লাইভ রোবট কলিং স্ট্যাটাস:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                const SizedBox(height: 6),
                Column(
                  children: robotVoiceData.values.map((data) {
                    bool isCalling = data['status'] == 'calling';
                    Color panelColor = Colors.orange[50]!;
                    Color borderCol = Colors.orange;
                    if (data['msg']!.contains('চূড়ান্ত')) {
                      panelColor = Colors.red[50]!;
                      borderCol = Colors.red;
                    } else if (data['msg']!.contains('১ম')) {
                      panelColor = Colors.amber[50]!;
                      borderCol = Colors.amber[700]!;
                    }

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCalling ? panelColor : Colors.green[50],
                        border: Border.all(color: isCalling ? borderCol : Colors.green, width: 1.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCalling ? Icons.phone_in_talk : Icons.check_circle,
                                color: isCalling ? borderCol : Colors.green,
                                size: 22
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  data['msg']!,
                                  style: TextStyle(color: isCalling ? Colors.black87 : Colors.green[900], fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.withOpacity(0.2))
                            ),
                            child: Text(
                              data['voice']!,
                              style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        
                ElevatedButton.icon(
                  onPressed: _showAddCustomerDialog,
                  icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                  label: const Text('নতুন কাস্টমার আইডি খুলুন', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 20),
                const Text('কাস্টমার খাতা (বাকি লিখতে নামের ওপর ক্লিক করুন):', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 10),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _customers.length,
                  itemBuilder: (context, index) {
                    final customer = _customers[index];
                    bool isCleared = customer.dueAmount <= 0;
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        // এখানে ব্যাকগ্রাউন্ড এরর দূর করতে Material উইজেট দেওয়া হয়েছে
                        child: Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: isCleared ? Colors.green : Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(isCleared ? Icons.done_all : Icons.person, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(customer.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, decoration: isCleared ? TextDecoration.lineThrough : null)),
                                      Text('আইডি: ${customer.id}', style: const TextStyle(color: Colors.blue, fontSize: 11, fontWeight: FontWeight.bold)),
                                      Text(
                                        isCleared ? 'বাকি পরিশোধিত' : 'শেষ তারিখ: ${customer.dueDate}', 
                                        style: TextStyle(color: isCleared ? Colors.green : Colors.red, fontSize: 11, fontWeight: FontWeight.bold)
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  isCleared ? 'পরিশোধিত' : '৳ ${customer.dueAmount.toStringAsFixed(0)}', 
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isCleared ? Colors.green : Colors.red)
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CustomerDetailsScreen(customer: customer, shopName: _myShopName)),
                          );
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerDetailsScreen extends StatefulWidget {
  final Customer customer;
  final String shopName;
  const CustomerDetailsScreen({super.key, required this.customer, required this.shopName});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final _itemController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _cashPaidController = TextEditingController();
  final _payDateController = TextEditingController();

  String get manualPayDate => _payDateController.text.isEmpty ? 'নির্ধারিত নয়' : _payDateController.text;

  @override
  Widget build(BuildContext context) {
    bool isCleared = widget.customer.dueAmount <= 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView( 
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isCleared ? Colors.green.withOpacity(0.1) : Colors.blue.withOpacity(0.1), 
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('কাস্টমার: ${widget.customer.name}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('দোকান: ${widget.shopName}', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 11)),
                        ],
                      ),
                      Text(
                        isCleared ? 'বাকি পরিশোধিত' : 'মোট বকেয়া: ৳ ${widget.customer.dueAmount.toStringAsFixed(0)}',
                        style: TextStyle(color: isCleared ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(' ইন-অ্যাপ ক্যালকুলেটর স্ক্রিন:', style: TextStyle(color: Colors.white, fontSize: 11)),
                      Text('৳ ${widget.customer.dueAmount.toStringAsFixed(0)} ', style: const TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                const Text('নতুন বিক্রি এবং নিট বাকি এন্ট্রি ফর্ম:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 6),
                TextField(
                  controller: _itemController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'পণ্যের নাম এবং বিবরণ', hintText: 'যেমন: তেল, ডাল, সাবান', isDense: true, prefixIcon: Icon(Icons.shopping_basket, size: 18)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _totalPriceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'মোট পণ্যের মূল্য', hintText: '৫০০০', isDense: true, prefixIcon: Icon(Icons.money, size: 18)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _cashPaidController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'নগদ জমা', hintText: '১৫০০', isDense: true, prefixIcon: Icon(Icons.money, size: 18)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _payDateController,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'টাকা পরিষদের তারিখ', hintText: 'যেমন: ৩০/০৬/২০২৬', isDense: true, prefixIcon: Icon(Icons.edit_calendar, size: 18, color: Colors.orange)),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {
                    if (_itemController.text.isNotEmpty && _totalPriceController.text.isNotEmpty) {
                      double total = double.tryParse(_totalPriceController.text) ?? 0.0;
                      double cash = double.tryParse(_cashPaidController.text) ?? 0.0;
                      double calculatedDue = total - cash; 

                      DateTime now = DateTime.now();
                      String automaticCurrentDate = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

                      setState(() {
                        widget.customer.history.insert(0, Transaction(
                          details: _itemController.text,
                          totalAmount: total,
                          cashPaid: cash,
                          netDue: calculatedDue,
                          buyDate: automaticCurrentDate, 
                          payDate: manualPayDate,   
                        ));
                        widget.customer.dueAmount += calculatedDue; 
                      });

                      _itemController.clear(); _totalPriceController.clear(); _cashPaidController.clear(); _payDateController.clear();
                    }
                  },
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text('হিসাব করে নিট বাকি যোগ করুন', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 45), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
                
                const SizedBox(height: 12),
                const Divider(thickness: 2),
                const SizedBox(height: 8),

                if (!isCleared)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        DateTime now = DateTime.now();
                        String currentDate = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
                        
                        widget.customer.history.insert(0, Transaction(
                          details: 'সম্পূর্ণ বকেয়া নগদ পরিশোধ',
                          totalAmount: widget.customer.dueAmount,
                          cashPaid: widget.customer.dueAmount,
                          netDue: 0,
                          buyDate: currentDate,
                          payDate: 'পরিশোধিত',
                        ));
                        widget.customer.dueAmount = 0; 
                      });
                    },
                    icon: const Icon(Icons.monetization_on, color: Colors.white),
                    label: const Text('টাকা পরিশোধ (বাকি শোধ করুন)', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  ),

                const SizedBox(height: 20),
                const Text('লেনদেনের খতিয়ান:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 6),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.customer.history.length,
                  itemBuilder: (context, index) {
                    final tx = widget.customer.history[index];
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text('বিবরণ: ${tx.details}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), overflow: TextOverflow.ellipsis)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                                  child: Text('তারিখ: ${tx.buyDate}', style: const TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const Divider(height: 12, thickness: 0.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('মোট মূল্য: ৳${tx.totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
                                    const SizedBox(height: 4),
                                    Text('নগদ জমা: ৳${tx.cashPaid.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('নিট বাকি: ৳${tx.netDue.toStringAsFixed(0)}', style: TextStyle(fontSize: 13, color: tx.netDue > 0 ? Colors.red : Colors.green, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text('পরিষদের তারিখ: ${tx.payDate}', style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
