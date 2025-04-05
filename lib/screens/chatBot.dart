//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ChatBot',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.light,
//         useMaterial3: true,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       themeMode: ThemeMode.system,
//       home: const ChatBotInterface(),
//     );
//   }
// }
//
// class ChatBotInterface extends StatefulWidget {
//   const ChatBotInterface({Key? key}) : super(key: key);
//
//   @override
//   State<ChatBotInterface> createState() => _ChatBotInterfaceState();
// }
//
// class Message {
//   final String text;
//   final bool isUser;
//   final bool isSystem;
//
//   Message({required this.text, this.isUser = false, this.isSystem = false});
// }
//
// class _ChatBotInterfaceState extends State<ChatBotInterface> {
//   final TextEditingController _inputController = TextEditingController();
//   final String apiUrl = "https://6b24-34-16-172-45.ngrok-free.app/chat";
//   final ScrollController _scrollController = ScrollController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//   String _debugInfo = '';
//   bool _showDebugInfo = false;
//   List<Message> _messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Add initial bot messages
//     _messages.add(Message(text: "Hello there! 👋 It's nice to meet you!", isSystem: true));
//     _messages.add(Message(
//         text: "What brings you here today? Please use the navigation below or ask me anything about ChatBot product. ✓",
//         isSystem: true));
//   }
//
//   Future<void> _getApiResponse(String prompt) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//       _debugInfo = '';
//       _messages.add(Message(text: prompt, isUser: true));
//     });
//
//     try {
//       final headers = {"Content-Type": "application/json"};
//       final payload = {"message": prompt};
//
//       // Add debug info
//       setState(() {
//         _debugInfo += "Sending request: ${jsonEncode(payload)}\n";
//       });
//
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(payload),
//       );
//
//       // Add raw response to debug info
//       setState(() {
//         _debugInfo += "Raw response: ${response.body}\n";
//       });
//
//       if (response.statusCode == 200) {
//         try {
//           // Try to parse the JSON response
//           final data = jsonDecode(response.body);
//
//           setState(() {
//             if (data == null) {
//               _messages.add(Message(text: "Received empty response from API", isSystem: true));
//             } else {
//               // For now, we'll just display the raw response
//               // In a real app, you'd parse the specific fields from the response
//               _messages.add(Message(text: response.body, isSystem: true));
//             }
//             _isLoading = false;
//           });
//
//           // Scroll to bottom after adding new message
//           _scrollToBottom();
//         } catch (e) {
//           setState(() {
//             _errorMessage = "Error parsing response: $e";
//             _debugInfo += "JSON parse error: $e\n";
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = "Error: HTTP ${response.statusCode} - ${response.body}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Exception: $e";
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   void _sendQuickReply(String text) {
//     _getApiResponse(text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.blue,
//               child: Text('C', style: TextStyle(color: Colors.white)),
//             ),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('ChatBot', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('Online', style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(_showDebugInfo ? Icons.visibility_off : Icons.visibility),
//             onPressed: () {
//               setState(() {
//                 _showDebugInfo = !_showDebugInfo;
//               });
//             },
//             tooltip: 'Toggle Debug Info',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Chat messages area
//           Expanded(
//             child: Container(
//               color: Colors.grey[100],
//               child: ListView.builder(
//                 controller: _scrollController,
//                 padding: const EdgeInsets.all(8),
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   final message = _messages[index];
//                   return _buildMessageBubble(message);
//                 },
//               ),
//             ),
//           ),
//
//           // Quick reply buttons
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 _buildQuickReplyButton('How to join cleanliness drive', Colors.green),
//                 _buildQuickReplyButton('How to arrange on demand Pickup 👍', Colors.green),
//                 _buildQuickReplyButton('I have question 😊', Colors.orange),
//                 _buildQuickReplyButton('My Request 👀', Colors.purple),
//               ],
//             ),
//           ),
//
//           // Error message
//           if (_errorMessage.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.red[100],
//               width: double.infinity,
//               child: Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red[900]),
//               ),
//             ),
//
//           // Debug info
//           if (_showDebugInfo && _debugInfo.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.grey[200],
//               width: double.infinity,
//               height: 100,
//               child: SingleChildScrollView(
//                 child: Text(
//                   'Debug Info:\n$_debugInfo',
//                   style: const TextStyle(
//                     fontFamily: 'monospace',
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//
//           // Input area
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 2,
//                   offset: const Offset(0, -1),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _inputController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message...',
//                       border: InputBorder.none,
//                     ),
//                     onSubmitted: (text) {
//                       if (text.isNotEmpty) {
//                         _getApiResponse(text);
//                         _inputController.clear();
//                       }
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: _isLoading
//                       ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                       : const Icon(Icons.send, color: Colors.blue),
//                   onPressed: _isLoading
//                       ? null
//                       : () {
//                     if (_inputController.text.isNotEmpty) {
//                       _getApiResponse(_inputController.text);
//                       _inputController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(Message message) {
//     return Align(
//       alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         decoration: BoxDecoration(
//           color: message.isUser ? Colors.blue : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 2,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (!message.isUser)
//               Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: CircleAvatar(
//                   radius: 16,
//                   backgroundColor: Colors.blue,
//                   child: Text(
//                     message.isSystem ? 'C' : 'U',
//                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                 ),
//               ),
//             Flexible(
//               child: Text(
//                 message.text,
//                 style: TextStyle(
//                   color: message.isUser ? Colors.white : Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickReplyButton(String text, Color color) {
//     return OutlinedButton(
//       onPressed: () => _sendQuickReply(text),
//       style: OutlinedButton.styleFrom(
//         side: BorderSide(color: color),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: color),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _inputController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }


































import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  // Add parameter for initial message
  final String? initialMessage;

  // Make it optional
  const ChatbotScreen({Key? key, this.initialMessage}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class Message {
  final String text;
  final bool isUser;
  final bool isSystem;
  final bool isInitialGreeting;

  Message({
    required this.text,
    this.isUser = false,
    this.isSystem = false,
    this.isInitialGreeting = false
  });
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _inputController = TextEditingController();
  final String apiUrl = "https://chat-production-4da7.up.railway.app/chat";
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  String _errorMessage = '';
  String _debugInfo = '';
  bool _showDebugInfo = false;
  List<Message> _messages = [];
  bool _isFirstUserMessage = true;

  @override
  void initState() {
    super.initState();
    // Add initial greeting
    _messages.add(Message(text: "Hello 👋,\nHow Can I Assist You?", isSystem: true, isInitialGreeting: true));

    // If initialMessage is provided, send it automatically after a short delay
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      // Short delay to allow the UI to render first
      Future.delayed(Duration(milliseconds: 300), () {
        _getApiResponse(widget.initialMessage!);
      });
    }
  }

  Future<void> _getApiResponse(String prompt) async {
    // If this is the first user message, clear the initial greeting
    if (_isFirstUserMessage) {
      setState(() {
        _messages.removeWhere((message) => message.isInitialGreeting);
        _isFirstUserMessage = false;
      });
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _debugInfo = '';
      _messages.add(Message(text: prompt, isUser: true));
    });

    try {
      final headers = {"Content-Type": "application/json"};
      final payload = {"message": prompt};

      // Add debug info
      setState(() {
        _debugInfo += "Sending request: ${jsonEncode(payload)}\n";
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      // Add raw response to debug info
      setState(() {
        _debugInfo += "Raw response: ${response.body}\n";
      });

      if (response.statusCode == 200) {
        try {
          // Parse the JSON response
          final data = jsonDecode(response.body);

          setState(() {
            if (data == null) {
              _messages.add(Message(text: "Received empty response from API", isSystem: true));
            } else if (data['response'] != null) {
              // Extract just the response text from the JSON
              _messages.add(Message(text: data['response'], isSystem: true));
            } else {
              // Fallback if response field is missing
              _messages.add(Message(text: "Received unexpected response format", isSystem: true));
            }
            _isLoading = false;
          });

          // Scroll to bottom after adding new message
          _scrollToBottom();
        } catch (e) {
          setState(() {
            _errorMessage = "Error parsing response: $e";
            _debugInfo += "JSON parse error: $e\n";
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = "Error: HTTP ${response.statusCode} - ${response.body}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Exception: $e";
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendQuickReply(String text) {
    _getApiResponse(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Fallback background color
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png', // Your logo image path
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text('E', style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Eco-AI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(86, 152, 94, 1), // Changed the color to rgb(86,152,94)
                    )
                ),
                Text('Online', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(_showDebugInfo ? Icons.visibility_off : Icons.visibility),
        //     onPressed: () {
        //       setState(() {
        //         _showDebugInfo = !_showDebugInfo;
        //       });
        //     },
        //     tooltip: 'Toggle Debug Info',
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),

          // Quick reply buttons - Only show if it's the first user message and no initialMessage
          if (_isFirstUserMessage && widget.initialMessage == null)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildQuickReplyButton('How to join cleanliness drive', Colors.green),
                  _buildQuickReplyButton('How to arrange on demand Pickup 👍', Colors.green),
                  _buildQuickReplyButton('I have question 😊', Colors.orange),
                  _buildQuickReplyButton('My Request 👀', Colors.purple),
                ],
              ),
            ),

          // Error message
          if (_errorMessage.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red[100],
              width: double.infinity,
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red[900]),
              ),
            ),

          // Debug info
          // if (_showDebugInfo && _debugInfo.isNotEmpty)
          //   Container(
          //     padding: const EdgeInsets.all(8),
          //     color: Colors.grey[200],
          //     width: double.infinity,
          //     height: 100,
          //     child: SingleChildScrollView(
          //       child: Text(
          //         'Debug Info:\n$_debugInfo',
          //         style: const TextStyle(
          //           fontFamily: 'monospace',
          //           fontSize: 12,
          //         ),
          //       ),
          //     ),
          //   ),

          // Redesigned input area with capsule shape
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          _getApiResponse(text);
                          _inputController.clear();
                        }
                      },
                    ),
                  ),
                  // Modified send button to remove the circle and keep just the icon
                  IconButton(
                    icon: _isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blue,
                      ),
                    )
                        : const Icon(Icons.send, color: Colors.blue),
                    onPressed: _isLoading
                        ? null
                        : () {
                      if (_inputController.text.isNotEmpty) {
                        _getApiResponse(_inputController.text);
                        _inputController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Parse text with formatting markers like ****bold text****
  List<InlineSpan> _parseFormattedText(String text) {
    final List<InlineSpan> spans = [];

    // Regular expression to match text between multiple asterisks
    // This will match **text** pattern
    final RegExp boldRegex = RegExp(r'\*\*(.*?)\*\*');

    // Start searching from the beginning of the text
    int currentIndex = 0;

    // Find all matches of the bold pattern
    Iterable<RegExpMatch> matches = boldRegex.allMatches(text);

    for (RegExpMatch match in matches) {
      // Add text before the match as normal text
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        );
      }

      // Add the matched text as bold
      spans.add(
        TextSpan(
          text: match.group(1), // The text between the asterisks
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      // Update the current position
      currentIndex = match.end;
    }

    // Add any remaining text
    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      );
    }

    return spans;
  }

  Widget _buildMessageBubble(Message message) {
    // For the initial greeting, center it with modified styling (no background box, green text)
    if (message.isInitialGreeting) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 150, bottom: 20, left: 8, right: 8),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(86, 152, 94, 1), // Changed to rgb(86,152,94)
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    // For other messages (user or system)
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue : Colors.white,
          // Make user messages more capsule-shaped with higher border radius
          borderRadius: BorderRadius.circular(message.isUser ? 24 : 16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Fallback background color
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.png', // Your avatar image path
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            message.isSystem ? 'E' : 'U',
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black,
                  ),
                  children: _parseFormattedText(message.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReplyButton(String text, Color color) {
    return OutlinedButton(
      onPressed: () => _sendQuickReply(text),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}