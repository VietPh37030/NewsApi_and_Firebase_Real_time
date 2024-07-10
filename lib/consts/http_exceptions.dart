class HttpExceptions implements Exception {
  final String codeMessage;

  HttpExceptions(this.codeMessage);

  String get getNewsApiErrorMessage {
    if (codeMessage.contains("apiKeyDisabled")) {
      return "API Key Disabled";
    } else if (codeMessage.contains("apiKeyExhausted")) {
      return "API Key Exhausted";
    } else if (codeMessage.contains("apiKeyInvalid")) {
      return "API Key Invalid";
    } else if (codeMessage.contains("apiKeyMissing")) {
      return "API Key Missing";
    } else if (codeMessage.contains("parametersMissing")) {
      return "Parameters";
    }else if (codeMessage.contains("rateLimited")){
      return "Rate Limited";
    }else if (codeMessage.contains("sourceTooMany")){
      return "Source Too Many";
    }else if (codeMessage.contains("sourceDoesNotExist")){
      return "Source Does Not Exist";
    }else if(codeMessage.contains("unexpectedError")){
      return "THis should\"t happen , and if it does then it\"s our fault,not yours . Try the request again short";
    }
    return "Something went wrong";
  }
  @override
  String toString() {
    return codeMessage;
  }
}
