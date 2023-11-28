// CUSTOM_CODE_STARTED
import 'package:mortgage_chat_app/chat_components/chat_action/chat_action_widget.dart';

import '../flutter_flow_theme.dart';
import 'index.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TimeDisplaySetting {
  alwaysVisible,
  alwaysInvisible,
  visibleOnTap,
}

final Uint8List transparentImage = Uint8List.fromList([
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

class FFChatWidget extends StatefulWidget {
  const FFChatWidget({
    super.key,
    required this.currentUser,
    required this.otherUser,
    required this.scrollController,
    required this.focusNode,
    required this.messages,
    required this.onSend,
    required this.otherUsers,
    required this.onMessageDeleted,
    this.uploadMediaAction,
    // Theme settings
    this.backgroundColor,
    this.timeDisplaySetting = TimeDisplaySetting.visibleOnTap,
    this.currentUserBoxDecoration,
    this.otherUsersBoxDecoration,
    this.currentUserTextStyle,
    this.otherUsersTextStyle,
    this.inputHintTextStyle,
    this.inputTextStyle,
    this.emptyChatWidget,
  });

  final ChatUser currentUser;
  final ChatUser otherUser;
  final List<ChatUser> otherUsers;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final List<ChatMessage> messages;
  final Function(ChatMessage) onSend;
  final Function()? uploadMediaAction;

  final Color? backgroundColor;
  final TimeDisplaySetting? timeDisplaySetting;
  final BoxDecoration? currentUserBoxDecoration;
  final BoxDecoration? otherUsersBoxDecoration;
  final TextStyle? currentUserTextStyle;
  final TextStyle? otherUsersTextStyle;
  final TextStyle? inputHintTextStyle;
  final TextStyle? inputTextStyle;
  final Widget? emptyChatWidget;
  final Function(DocumentReference) onMessageDeleted;

  @override
  _FFChatWidgetState createState() => _FFChatWidgetState();
}

class _FFChatWidgetState extends State<FFChatWidget> {
  TextEditingController textEditingController = TextEditingController();
  Map<String, bool> messageHoverStates = {};

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  Future<void> _deleteMessage(DocumentReference chatMessageRef) async {
    try {
      await chatMessageRef.delete();
      setState(() {
        widget.messages.removeWhere((message) =>
            message.customProperties?['reference'] == chatMessageRef);
        widget.onMessageDeleted(chatMessageRef);
      });
    } catch (e) {
      print(e);
    }
  }

  bool onMessageHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.focusNode.unfocus,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Theme(
                data: ThemeData(
                    canvasColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    dialogBackgroundColor: Colors.transparent),
                child: DashChat(
                  scrollToBottomOptions: ScrollToBottomOptions(
                    scrollToBottomBuilder: (scrollController) {
                      return DefaultScrollToBottom(
                        scrollController: scrollController,
                        backgroundColor: Colors.white,
                        textColor: FlutterFlowTheme.of(context).primary,
                      );
                    },
                  ),
                  currentUser: widget.currentUser,
                  messages: widget.messages.reversed.toList(),
                  inputOptions: InputOptions(
                    alwaysShowSend: true,
                    textController: textEditingController,
                    sendOnEnter: false,
                    sendButtonBuilder: (Function() onSend) {
                      // Change the color based on whether there is text
                      Color sendButtonColor =
                          textEditingController.text.trim().isNotEmpty
                              ? Colors.blue // Blue when there is text
                              : Colors.grey; // Grey when empty
                      return IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: textEditingController.text.trim().isNotEmpty
                            ? () => onSend()
                            : null,
                        color: sendButtonColor,
                        disabledColor:
                            Colors.grey, // Color when the button is disabled
                        iconSize: 25.0,
                      );
                    },
                    cursorStyle: const CursorStyle(color: Color(0xFF0038FF)),
                    onMention: (trigger, value, onMentionClick) async {
                      // Filter the list of users based on the input value.
                      List<ChatUser> mentionSuggestions = widget.otherUsers
                          .where((user) => user.firstName!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();

                      // Check if suggestions are found
                      if (mentionSuggestions.isEmpty) {
                        return [];
                      }

                      // Create a list of ListTiles for each suggestion.
                      List<Widget> suggestionWidgets =
                          mentionSuggestions.map((user) {
                        return Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(color: const Color(0xFFF4F4F4))),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: mentionSuggestions.map((user) {
                              return ListTile(
                                leading: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: transparentImage,
                                      image: user.profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                title: Row(children: [
                                  Text(
                                    user.firstName!,
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(" - ",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  Text(
                                    user.getFullName(),
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )
                                ]),

                                onTap: () {
                                  onMentionClick(user.firstName!);
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                tileColor: Colors
                                    .white, // Background color of the tile
                              );
                            }).toList(),
                          ),
                        );
                      }).toList();

                      return suggestionWidgets;
                    },
                    textInputAction: TextInputAction.send,
                    inputToolbarPadding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 0,
                      top: 0,
                    ),
                    inputToolbarMargin: const EdgeInsets.only(top: 20.0),
                    inputDecoration: InputDecoration(
                      hintText: "Message @${widget.otherUser.firstName}",
                      hintStyle: widget.inputHintTextStyle ??
                          const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Adjust the padding as needed
                        child: IconButton(
                            icon: Container(
                              width:
                                  28.0, // Adjust the container size as needed
                              height: 28.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4F4F4), // Background color
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xFF848484), // Icon color
                                size: 18.0, // Icon size
                              ),
                            ),
                            onPressed: widget.uploadMediaAction),
                      ),
                    ),
                    inputToolbarStyle: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  messageListOptions:
                      MessageListOptions(dateSeparatorBuilder: (DateTime date) {
                    String formattedDate;
                    DateTime now = DateTime.now();
                    DateTime today = DateTime(now.year, now.month, now.day);
                    DateTime yesterday =
                        DateTime(now.year, now.month, now.day - 1);
                    DateTime messageDate =
                        DateTime(date.year, date.month, date.day);

                    if (messageDate == today) {
                      formattedDate = 'Today';
                    } else if (messageDate == yesterday) {
                      formattedDate = 'Yesterday';
                    } else {
                      formattedDate = DateFormat('dd/MM/yyyy').format(date);
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Divider(
                            height: 1,
                            color: Color(0xFFD2D2D2),
                            thickness: 1,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFD2D2D2), width: 1),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              formattedDate,
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            height: 1,
                            color: Color(0xFFD2D2D2),
                            thickness: 1,
                          ),
                        ),
                      ],
                    );
                  }),
                  messageOptions: MessageOptions(
                    messageRowBuilder: (message, previousMessage, nextMessage,
                        isAfterDateSeparator, isBeforeDateSeparator) {
                      bool isDifferentUser = previousMessage == null ||
                          message.user.id != previousMessage.user.id;
                      bool isWithinFiveMinutes = previousMessage != null &&
                          message.createdAt
                                  .difference(previousMessage.createdAt)
                                  .inMinutes
                                  .abs() <=
                              5;
                      bool shouldShowAvatar =
                          isDifferentUser || !isWithinFiveMinutes;

                      double topPadding = isAfterDateSeparator
                          ? 25
                          : (isDifferentUser ? 25 : 5);
                      return GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // The widget you provided
                              return Center(
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 200),
                                  width: 300.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          thickness: 3.0,
                                          indent: 100.0,
                                          endIndent: 100.0,
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 8.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 0.0),
                                                    child: Icon(
                                                      Icons.edit_square,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Text(
                                                        'Edit message',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Icon(
                                                    Icons.send_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 0.0),
                                                    child: Text(
                                                      'Forward message',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Icon(
                                                    Icons.content_copy_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 0.0),
                                                    child: Text(
                                                      'Copy text',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: message.user.id ==
                                                  widget.currentUser.id
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 8.0, 0.0, 8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          color:
                                                              Color(0xFFFF0000),
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              await _deleteMessage(
                                                                  message.customProperties?[
                                                                      'reference']);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Delete message',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: const Color(
                                                                        0xFFFF0000),
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(height: 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: topPadding,
                              bottom: isBeforeDateSeparator ? 25 : 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar
                                shouldShowAvatar
                                    ? Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: FadeInImage.memoryNetwork(
                                            placeholder: transparentImage,
                                            image: message.user.profileImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 38,
                                      ),

                                const SizedBox(
                                    width:
                                        8), // Space between avatar and message
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // User name
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (shouldShowAvatar)
                                            Text(
                                              message.user.firstName ?? '',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          if (shouldShowAvatar)
                                            Text(
                                              DateFormat.jm()
                                                  .format(message.createdAt),
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF848484),
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (shouldShowAvatar)
                                        const SizedBox(height: 6),
                                      Container(
                                        constraints:
                                            const BoxConstraints(minHeight: 25),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(message.text,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                            const SizedBox(width: 8),
                                            if (!shouldShowAvatar &&
                                                messageHoverStates[message
                                                        .hashCode
                                                        .toString()] ==
                                                    true)
                                              Text(
                                                DateFormat.jm()
                                                    .format(message.createdAt),
                                                style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  height: 1.2,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  onSend: widget.onSend,
                ),
              ),
            ),
            if (widget.messages.isEmpty && widget.emptyChatWidget != null)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: FlutterFlowTheme.of(context).primary,
                ),
              )
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(bottom: 15),
            //           child: Container(
            //             width: 38,
            //             height: 38,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(4.0),
            //             ),
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(4.0),
            //               child: FadeInImage.memoryNetwork(
            //                 placeholder: transparentImage,
            //                 image: widget.otherUser.profileImage!,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //         ),
            //         Text(
            //           widget.otherUser.firstName ?? '',
            //           textAlign: TextAlign.center,
            //           style: GoogleFonts.inter(
            //             fontSize: 17,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.black,
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 15),
            //           child: Text(
            //             "Hello deerie. I help those with cats find the perfect property. Specialities: NSW. Cats.",
            //             style: GoogleFonts.inter(
            //                 color: const Color(0xFF848484),
            //                 fontSize: 14,
            //                 height: 1.5),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
  
// CUSTOM_CODE_ENDED
