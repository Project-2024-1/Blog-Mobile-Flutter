String getPlanJaText(String planName) {
  switch (planName) {
    case "trial":
      return "無料";
    case "pro":
      return "有料プラン";
    default:
      return planName;
  }
}
