import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../theme/text_styles.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final List<Map<String, dynamic>> transactions = [
    {
      'type': 'Received BNB',
      'date': 'Mar 21, 2023',
      'time': '10:32AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40.00',
      'status': 'success',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'failed',
    },
    // ... (other transactions)
  ];

  Map<String, dynamic> currentFilters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 30),
        child: Padding(
          padding: const EdgeInsets.only(top: 45),
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IconButton(
                icon: Icon(Icons.chevron_left, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            title: const SizedBox.shrink(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
            child: Text(
              'Transaction History',
              style: CustomTextStyles.primaryTitle.copyWith(
                fontWeight: FontWeight.w600,
                color: Color(0xff101928),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFE4E4E7).withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Image.asset('assets/images/transaction/search.png'),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search assets',
                        hintStyle: CustomTextStyles.secondaryTitle.copyWith(
                          fontSize: 14,
                          color: Color(0xffA0A0AB),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/svg/filter-lines.svg'),
                    onPressed: () => _showFilterBottomSheet(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: transaction['status'] == 'success'
                                ? const Color(0xFF6E56F8).withOpacity(0.15)
                                : Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            transaction['status'] == 'success'
                                ? 'assets/images/transaction/success.png'
                                : 'assets/images/transaction/unsuccess.png',
                            color: transaction['status'] == 'success'
                                ? const Color(0xFF6E56F8)
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction['type'],
                                style: CustomTextStyles.mediumText.copyWith(
                                  color: Color(0xff1D2739),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${transaction['date']} | ${transaction['time']}',
                                style: CustomTextStyles.secondaryTitle.copyWith(
                                  fontSize: 14,
                                  color: Color(0xff667185),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              transaction['amount'],
                              style: CustomTextStyles.mediumText.copyWith(
                                fontSize: 14,
                                color: Color(0xff1D2739),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaction['amountUSD'],
                              style: CustomTextStyles.secondaryTitle.copyWith(
                                fontSize: 14,
                                color: Color(0xff475367),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionFilterSheet(
        offerStatuses: ['Pending', 'Completed', 'Failed'],
        orders: ['Buy', 'Sell'],
        cryptoTypes: ['BTC', 'ETH', 'USDT', 'BNB'],
        onApply: (filters) {
          setState(() {
            currentFilters = filters;
          });
          // Apply filters to transactions list
          // This is where you would typically call an API or filter the local data
          print('Filters applied: $filters');
        },
      ),
    );
  }
}

class TransactionFilterSheet extends StatefulWidget {
  final Function(Map<String, dynamic>)? onApply;
  final List<String>? offerStatuses;
  final List<String>? orders;
  final List<String>? cryptoTypes;

  const TransactionFilterSheet({
    Key? key,
    this.onApply,
    this.offerStatuses,
    this.orders,
    this.cryptoTypes,
  }) : super(key: key);

  @override
  State<TransactionFilterSheet> createState() => _TransactionFilterSheetState();
}

class _TransactionFilterSheetState extends State<TransactionFilterSheet> {
  String? selectedOfferStatus;
  String? selectedOrder;
  String? selectedCrypto;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Filter',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF101928),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (widget.offerStatuses != null) ...[
            Text(
              'Offer status',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF344054),
              ),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              value: selectedOfferStatus,
              hint: 'Select offer status',
              items: widget.offerStatuses!,
              onChanged: (value) => setState(() => selectedOfferStatus = value),
            ),
            const SizedBox(height: 16),
          ],
          if (widget.orders != null) ...[
            Text(
              'Order',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF344054),
              ),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              value: selectedOrder,
              hint: 'Select crypto type',
              items: widget.orders!,
              onChanged: (value) => setState(() => selectedOrder = value),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            'Date',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF344054),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  label: 'From',
                  value: fromDate,
                  onTap: () => _selectDate(context, true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField(
                  label: 'To',
                  value: toDate,
                  onTap: () => _selectDate(context, false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (widget.cryptoTypes != null) ...[
            Text(
              'Crypto',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF344054),
              ),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              value: selectedCrypto,
              hint: 'Select crypto type',
              items: widget.cryptoTypes!,
              onChanged: (value) => setState(() => selectedCrypto = value),
            ),
            const SizedBox(height: 24),
          ],
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                          color: const Color(0xFF6E56F8).withOpacity(0.5)),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6E56F8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.onApply != null) {
                      widget.onApply!({
                        'offerStatus': selectedOfferStatus,
                        'order': selectedOrder,
                        'fromDate': fromDate,
                        'toDate': toDate,
                        'crypto': selectedCrypto,
                      });
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E56F8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Apply Filter',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF667085),
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF101928),
          ),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD0D5DD)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value != null ? DateFormat('dd/MM/yy').format(value) : label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: value != null
                      ? const Color(0xFF101928)
                      : const Color(0xFF667085),
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Color(0xFF667085),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }
}
