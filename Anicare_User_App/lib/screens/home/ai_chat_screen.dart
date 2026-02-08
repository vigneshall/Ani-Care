import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/constants.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello! I\'m AniCare AI Assistant. I can help you with pet health advice, care tips, and answer questions about animal welfare. How can I help you today?',
      isUser: false,
      timestamp: DateTime.now(),
    ),
  ];
  bool _isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final userMessage = ChatMessage(
      text: _messageController.text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    final userQuestion = _messageController.text;
    _messageController.clear();

    // Get AI response from API
    final aiResponseText = await _getAIResponse(userQuestion);

    final aiResponse = ChatMessage(
      text: aiResponseText,
      isUser: false,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(aiResponse);
      _isLoading = false;
    });
  }

  Future<String> _getAIResponse(String question) async {
    // Check if question is related to animal care
    if (!_isAnimalCareQuestion(question)) {
      return 'I can only answer questions related to animal care, pet health, veterinary advice, and animal welfare. Please ask me about pets, animals, or their care.';
    }

    try {
      // Replace with your actual AI API endpoint
      // Example: OpenAI, Anthropic, or custom AI service
      final response = await http.post(
        Uri.parse('YOUR_AI_API_ENDPOINT'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_API_KEY',
        },
        body: jsonEncode({
          'prompt': 'You are an animal care expert. Answer this question: $question',
          'max_tokens': 150,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? _generateFallbackResponse(question);
      } else {
        return _generateFallbackResponse(question);
      }
    } catch (e) {
      // Fallback to local responses if API fails
      return _generateFallbackResponse(question);
    }
  }

  bool _isAnimalCareQuestion(String question) {
    final lowerQuestion = question.toLowerCase();
    final animalKeywords = [
      'pet', 'dog', 'cat', 'animal', 'vet', 'veterinary', 'health', 'sick',
      'vaccine', 'food', 'diet', 'behavior', 'train', 'puppy', 'kitten',
      'rescue', 'adopt', 'care', 'feed', 'medical', 'emergency', 'injury',
      'stray', 'wildlife', 'bird', 'rabbit', 'hamster', 'fish', 'horse',
    ];
    return animalKeywords.any((keyword) => lowerQuestion.contains(keyword));
  }

  String _generateFallbackResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains('health') || lowerMessage.contains('sick')) {
      return 'For health concerns, it\'s best to consult with a veterinarian. However, make sure your pet has access to clean water, proper nutrition, and regular exercise. If symptoms persist, please schedule an appointment with a vet immediately.';
    } else if (lowerMessage.contains('vaccine') || lowerMessage.contains('vaccination')) {
      return 'Vaccinations are crucial for pet health. Regular vaccinations protect against common diseases. Puppies/kittens typically start at 6-8 weeks old. Consult your vet for a personalized vaccination schedule for your pet.';
    } else if (lowerMessage.contains('food') || lowerMessage.contains('diet')) {
      return 'A balanced diet is essential for your pet\'s health. Choose age-appropriate food and maintain consistent feeding schedules. Avoid human foods that are toxic to pets. Always provide fresh water. Consult your vet about specific dietary needs.';
    } else if (lowerMessage.contains('behavior') || lowerMessage.contains('train')) {
      return 'Behavioral issues require patience and consistency. Use positive reinforcement, establish routines, and be patient. For severe issues, consider working with a professional animal behaviorist or trainer.';
    } else if (lowerMessage.contains('emergency') || lowerMessage.contains('urgent')) {
      return 'For emergencies, please contact a veterinary emergency clinic immediately. Signs of emergency include difficulty breathing, severe injuries, loss of consciousness, or uncontrollable bleeding.';
    } else if (lowerMessage.contains('adopt') || lowerMessage.contains('rescue')) {
      return 'Adoption and rescue are wonderful ways to give pets a new home. Make sure you\'re prepared for the responsibility. Consider the pet\'s age, size, and temperament before adoption.';
    } else if (lowerMessage.contains('thank')) {
      return 'You\'re welcome! I\'m here to help. Feel free to ask me anything about pet care and wellness.';
    } else {
      return 'That\'s a great question! I can help with pet health, nutrition, behavior, training, and general care advice. For specific medical concerns, always consult with a veterinarian. What else would you like to know?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AniCare AI Assistant'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('AI is typing...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask me about pet care...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment:
              message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                color: message.isUser ? Colors.white70 : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
