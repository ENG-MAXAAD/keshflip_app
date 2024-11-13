import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionFilterSheet extends StatefulWidget {
  final Function(Map<String, dynamic>)? onApplyFilter;

  const TransactionFilterSheet({
    Key? key,
    this.onApplyFilter,
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
          _buildFilterSection(
            title: 'Offer status',
            child: _buildDropdown(
              hint: 'Select offer status',
              value: selectedOfferStatus,
              onChanged: (value) => setState(() => selectedOfferStatus = value),
              items: ['Pending', 'Completed', 'Cancelled'],
            ),
          ),
          const SizedBox(height: 24),
          _buildFilterSection(
            title: 'Order',
            child: _buildDropdown(
              hint: 'Select crypto type',
              value: selectedOrder,
              onChanged: (value) => setState(() => selectedOrder = value),
              items: ['Buy', 'Sell'],
            ),
          ),
          const SizedBox(height: 24),
          _buildFilterSection(
            title: 'Date',
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF475367),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDatePicker(
                        value: fromDate,
                        onTap: () => _selectDate(context, true),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF475367),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDatePicker(
                        value: toDate,
                        onTap: () => _selectDate(context, false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildFilterSection(
            title: 'Crypto',
            child: _buildDropdown(
              hint: 'Select crypto type',
              value: selectedCrypto,
              onChanged: (value) => setState(() => selectedCrypto = value),
              items: ['BTC', 'ETH', 'BNB', 'USDT'],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedOfferStatus = null;
                      selectedOrder = null;
                      selectedCrypto = null;
                      fromDate = null;
                      toDate = null;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: const Color(0xFF6E56F8).withOpacity(0.5),
                      ),
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
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.onApplyFilter != null) {
                      widget.onApplyFilter!({
                        'offerStatus': selectedOfferStatus,
                        'order': selectedOrder,
                        'crypto': selectedCrypto,
                        'fromDate': fromDate,
                        'toDate': toDate,
                      });
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E56F8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
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

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF101928),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required Function(String?) onChanged,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE4E4E7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(
          hint,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF667185),
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF101928),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDatePicker({
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE4E4E7)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value?.toString().split(' ')[0] ?? 'DD/MM/YY',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: value != null
                      ? const Color(0xFF101928)
                      : const Color(0xFF667185),
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Color(0xFF667185),
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
      lastDate: DateTime(2025),
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
