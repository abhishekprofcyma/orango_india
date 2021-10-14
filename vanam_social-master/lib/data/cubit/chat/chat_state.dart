import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/chat/chat_file_upload.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}
class ChatInitial extends ChatState {}
class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});
}
class ChatFileUploadLoading extends ChatState {}
class ChatFileUploadCompleted extends ChatState {
  final ChatFileUploadResponse chatFileUploadResponse;

  ChatFileUploadCompleted({required this.chatFileUploadResponse});
}
