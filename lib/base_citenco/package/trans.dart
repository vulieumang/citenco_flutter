import 'package:cnvsoft/base_citenco/package/translation.dart';

class BaseTrans extends BaseTranslation {
  static BaseTrans? _internal;

  BaseTrans._();

  factory BaseTrans() {
    if (_internal == null) _internal = BaseTrans._();
    return _internal!;
  }

  @override
  String get key => "base_citenco";

  String get $login => super.get("login");

  String get $logout => super.get("logout");

  String get $moveAccount => super.get("move_account");

  String get $restaurant => super.get("restaurant");

  String get $sending => super.get("sending");

  String get $history => super.get("history");

  String get $wineCard => super.get("wine_card");

  String get $takeTheWine => super.get("take_the_wine");

  String get $sentDate => super.get("sent_date");

  String get $QRTakeTheWine => super.get("QR_take_the_wine");

  String get $searchHint => super.get("search_hint");

  String get $dateOfPurchase => super.get("date_of_purchase");

  String get $use => super.get("use");

  String get $amountOfWine => super.get("amount_of_wine");

  String get $takenTheWine => super.get("taken_the_wine");

  String get $expiredTheWine => super.get("expired_the_wine");

  String get $day => super.get("day");

  String get $hours => super.get("hours");

  String get $minutes => super.get("minutes");

  String get $seconds => super.get("seconds");

  String get $myReward => super.get("my_reward");

  String get $reward => super.get("reward");

  String get $all => super.get("all");

  String get $loginByPhoneNumber => super.get("login_by_phone_number");

  String get $loginByFacebook => super.get("login_by_facebook");

  String get $loginByApple => super.get("login_by_apple");

  String get $loginByGoogle => super.get("login_by_google");

  String get $booking => super.get("booking");

  String get $viewMore => super.get("view_more");

  String get $news => super.get("news");

  String get $bookingNow => super.get("booking_now");

  String get $home => super.get("home");

  String get $profile => super.get("profile");

  String get $rewardDetail => super.get("reward_detail");

  String get $from => super.get("from");

  String get $to => super.get("to");

  String get $point => super.get("point");

  String get $usedNow => super.get("used_now");

  String get $makeSureBuyReward => super.get("make_sure_buy_reward");

  String get $makeSureUseReward => super.get("make_sure_use_reward");

  String get $confirm => super.get("confirm");

  String get $latest => super.get("latest");

  String get $pointFromLowToHigh => super.get("point_from_low_to_high");

  String get $pointFromHighToLow => super.get("point_from_high_to_low");

  String get $seriatedAToZ => super.get("seriated_a_to_z");

  String get $rewardCategory => super.get("reward_category");

  String get $sort => super.get("sort");

  String get $rewardListNotAvailable => super.get("reward_list_not_available");

  String $member(List<String> args) => super.get("member", args);

  String get $courseDetail => super.get("course_detail");

  String get $specialReward => super.get("special_reward");

  String get $rewardForYou => super.get("reward_for_you");

  String get $used => super.get("used");

  String get $new => super.get("new");

  String get $noStar => super.get("no_star");

  String get $thanksForReviews => super.get("thanks_for_reviews");

  String get $yourReview => super.get("your_review");

  String get $reviewsMsg => super.get("reviews_msg");

  String get $somethingNeedChange => super.get("something_need_change");

  String get $reviewNoteTitle => super.get("review_note_title");

  String get $noteHinttextReviews => super.get("note_hinttext_reviews");

  String get $sendFeedback => super.get("send_feedback");

  String get $pay => super.get("pay");

  String get $reviews => super.get("reviews");

  String get $reviewsThanksMes1 => super.get("reviews_thanks_mes_1");

  String get $reviewsThanksMes2 => super.get("reviews_thanks_mes_2");

  String get $alreadyRated => super.get("already_rated");

  String get $orderDetail => super.get("order_detail");

  String get $size => super.get("size");

  String get $note => super.get("note");

  String get $totalPrice => super.get("total_price");

  String get $priceDiscount => super.get("price_discount");

  String get $useVoucher => super.get("use_voucher");

  String get $priceToPay => super.get("price_to_pay");

  String get $priceHasPayment => super.get("price_has_payment");

  String get $orderInfo => super.get("order_info");

  String get $paymentBank => super.get("payment_bank");

  String get $cashPayment => super.get("cash_payment");

  String get $paymentViaVnpay => super.get("payment_via_vnpay");

  String get $paymentMenthods => super.get("payment_menthods");

  String get $status => super.get("status");

  String get $paymentInfo => super.get("payment_info");

  String get $choosePaymentMenthods => super.get("choose_payment_menthods");

  String get $store => super.get("store");

  String get $inputAdd => super.get("input_add");

  String get $askPermission => super.get("ask_permission");

  String get $openTime => super.get("open_time");

  String get $contact => super.get("contact");

  String get $location => super.get("location");

  String get $locationOf => super.get("location_of");

  String get $directionsToTheLocation =>
      super.get("directions_to_the_location");

  String get $address => super.get("address");

  String get $mesSearchLocation => super.get("mes_search_location");

  String get $hintSearchLocation => super.get("hint_search_location");

  String get $addressSearchNotFound => super.get("address_search_not_found");

  String $connection(List<String> args) => super.get("connection", args);

  String $detail(List<String> args) => super.get("detail", args);
  String get $detail1 => super.get("detail");
  String get $noData => super.get("no_data");

  String get $chooseDay => super.get("choose_day");

  String get $cancel => super.get("cancel");

  String get $scan => super.get("scan");

  String get $permissionCamera => super.get("permission_camera");

  String get $moveCameraMes => super.get("move_camera_mes");

  String get $inputQrcode => super.get("input_qrcode");

  String get $inputQrcodeMes => super.get("input_qrcode_mes");

  String get $storePin => super.get("store_pin");

  String get $inputStorePin => super.get("input_store_pin");

  String get $usedSuccess => super.get("used_success");

  String get $close => super.get("close");

  String get $editProfile => super.get("edit_profile");

  String get $save => super.get("save");

  String get $changeAvatar => super.get("change_avatar");

  String get $chooseFromTheLibrary => super.get("choose_from_the_library");

  String get $takePicture => super.get("take_picture");

  String get $userInfo => super.get("user_info");

  String get $fullname => super.get("fullname");

  String get $birthday => super.get("birthday");

  String get $email => super.get("email");

  String get $phonenumber => super.get("phonenumber");

  String get $sex => super.get("sex");

  String get $male => super.get("male");

  String get $female => super.get("female");

  String get $takePictureSus => super.get("take_picture_sus");

  String get $editPic => super.get("edit_pic");

  String get $phoneNotVerified => super.get("phone_not_verified");

  String get $resendVerificationCode => super.get("resend_verification_code");

  String get $inputVerification => super.get("input_verification");

  String get $verificationTimeDown => super.get("verification_time_down");

  String get $hello => super.get("hello");

  String get $helloMes => super.get("hello_mes");

  String get $continue => super.get("continue");

  String get $inputPhone => super.get("input_phone");

  String get $invalidPhone => super.get("invalid_phone");

  String get $short => super.get("short");

  String get $invalidCredential => super.get("invalidCredential");

  String get $verifyPhoneNumberError => super.get("verifyPhoneNumberError");

  String get $tooManyRequests => super.get("tooManyRequests");

  String get $quotaExceeded => super.get("quotaExceeded");

  String get $firebaseAuth => super.get("firebaseAuth");

  String get $tooShortPhoneNumber => super.get("tooShortPhoneNumber");

  String get $tooLongPhoneNumber => super.get("tooLongPhoneNumber");

  String get $invalidFormatPhoneNumber => super.get("invalidFormatPhoneNumber");

  String get $appNotAuthorized => super.get("appNotAuthorized");

  String get $invalidVerificationCode => super.get("invalidVerificationCode");

  String get $country => super.get("country");

  String get $skip => super.get("skip");

  String get $loginHomeMes => super.get("login_home_mes");

  String get $setting => super.get("setting");

  String get $wantToLogout => super.get("want_to_logout");

  String get $accumulationHistory => super.get("accumulation_history");

  String get $help => super.get("help");

  String get $orther => super.get("orther");

  String get $backApp => super.get("back_app");

  String get $phonenumberFail => super.get("phonenumber_fail");

  String get $updateProfile => super.get("update_profile");

  String get $mustLogin => super.get("must_login");

  String get $notification => super.get("notification");

  String get $yes => super.get("yes");

  String get $no => super.get("no");

  String get $finished => super.get("finished");

  String get $hasError => super.get("has_error");

  String get $newVesion => super.get("new_vesion");

  String get $newVesionMes => super.get("new_vesion_mes");

  String get $updateNow => super.get("update_now");

  String get $blankNumber => super.get("blank_number");

  String get $shortNumber => super.get("short_number");

  String get $comeback => super.get("comeback");

  String get $updatePhone => super.get("update_phone");

  String get $blankPage => super.get("blank_page");

  String get $noticeDetails => super.get("notice_details");

  String get $chooseTime => super.get("choose_time");

  String get $chooseDateBooking => super.get("choose_date_booking");

  String get $otherDate => super.get("other_date");

  String get $today => super.get("today");

  String get $choose => super.get("choose");

  String get $searchBooking => super.get("search_booking");

  String get $bookingInitMessage => super.get("booking_initMessage");

  String get $bookingHintsearch => super.get("booking_hintsearch");

  String get $present => super.get("present");

  String get $bookingEmptyMes => super.get("booking_empty_mes");

  String get $bookingEmptyNameMes => super.get("booking_empty_name_mes");

  String get $bookingEmptyMailMes => super.get("booking_empty_mail_mes");

  String get $plsInputName => super.get("pls_input_name");

  String get $plsValidPhone => super.get("pls_valid_phone");

  String get $plsValidMail => super.get("pls_valid_mail");

  String get $userInfoBooking => super.get("user_info_booking");

  String get $forMe => super.get("for_me");

  String get $forOtherPeople => super.get("for_other_people");

  String get $questionBooking => super.get("question_booking");

  String get $chooseAddress => super.get("choose_address");

  String get $chooseAddressMes => super.get("choose_address_mes");

  String get $chooseSpace => super.get("choose_space");

  String get $chooseTypeParty => super.get("choose_type_party");

  String get $bookingInfo => super.get("booking_info");

  String get $countPeople => super.get("count_people");

  String get $agree => super.get("agree");

  String get $typeParty => super.get("type_party");

  String get $space => super.get("space");

  String get $receiptOfTables => super.get("receipt_of_Tables");

  String get $tableCode => super.get("table_code");

  String get $recipientInfo => super.get("recipient_info");

  String get $severErr => super.get("sever_err");

  String get $bookingConfirm => super.get("booking_confirm");

  String get $bookingSuccess => super.get("booking_success");

  String get $bookingSuccessMes => super.get("booking_success_mes");

  String get $goHome => super.get("go_home");

  String get $amount => super.get("amount");

  String get $bookingAcceptTable => super.get("booking_accept_table");

  String get $cancelled => super.get("cancelled");

  String get $hasReceived => super.get("has_received");

  String get $yourReward => super.get("your_reward");

  String get $yourPhone => super.get("your_phone");

  String get $phoneInvalidFormat => super.get("phone_invalid_format");

  String get $tokenNotExist => super.get("token_not_exist");

  String get $pending => super.get("pending");

  String get $confirmed => super.get("confirmed");

  String get $pendingToSeat => super.get("pending_to_seat");

  String get $plsInputVerificationCode =>
      super.get("pls_input_verification_code");

  String get $plsInputPhone => super.get("pls_input_phone");

  String get $socialLogin => super.get("social_login");

  String get $loginErr => super.get("login_err");

  String get $errorInvalidVerificationCode =>
      super.get("error_invalid_verification_code");

  String get $errorMissingVerificationCode =>
      super.get("error_missing_verification_code");

  String get $errorSessionExpired => super.get("error_session_expired");

  String get $errorTooManyRequests => super.get("error_too_many_requests");

  String get $errorInvalidPhoneNumber =>
      super.get("error_invalid_phone_number");

  String get $pointsReceived => super.get("points_received");

  String get $expiringSoon => super.get("expiring_soon");

  String get $buyRewardSucc => super.get("buy_reward_succ");

  String get $expiryDate => super.get("expiry_date");

  String get $goToMyReward => super.get("go_to_my_reward");

  String get $yourRewardCode => super.get("your_reward_code");

  String get $rewardCodeUsed => super.get("reward_code_used");

  String get $qrCodeRewardMes => super.get("qr_code_reward_mes");

  String get $crossCheckingReward => super.get("cross_checking_reward");

  String get $rewardPecial => super.get("reward_pecial");

  String get $promotion => super.get("promotion");

  String get $edit => super.get("edit");

  String get $rewardChangeErr => super.get("reward_change_err");

  String $expriedDate(List<String> args) => super.get("expried_date", args);

  String get $validUntil => super.get("valid_until");

  String get $redeemRewards => super.get("redeem_rewards");

  String $rankUp(List<String> args) => super.get("rank_up", args);

  String get $noContent => super.get("no_content");

  String get $expires => super.get("expires");

  String get $dueDate => super.get("due_date");

  String get $updatePaymentMenthod => super.get("update_payment_menthod");

  String get $selectPaymentMenthod => super.get("select_payment_menthod");

  String get $january => super.get("january");

  String get $february => super.get("february");

  String get $march => super.get("march");

  String get $april => super.get("april");

  String get $may => super.get("may");

  String get $june => super.get("june");

  String get $july => super.get("july");

  String get $august => super.get("august");

  String get $september => super.get("september");

  String get $october => super.get("october");

  String get $november => super.get("november");

  String get $december => super.get("december");

  String get $mon => super.get("mon");

  String get $tue => super.get("tue");

  String get $wed => super.get("wed");

  String get $thu => super.get("thu");

  String get $fri => super.get("fri");

  String get $sat => super.get("sat");

  String get $sun => super.get("sun");

  String get $default => super.get("default");

  String get $chooseLang => super.get("choose_lang");

  String get $brand => super.get("brand");

  String get $language => super.get("language");

  String get $save2 => super.get("save2");

  String get $vietnamese => super.get("vietnamese");

  String get $english => super.get("english");

  String $featuredTitle(List<String> args) => super.get("featured_title", args);

  String $latestTitle(List<String> args) => super.get("latest_title", args);

  String get $pleaseWaiting => super.get("please_waiting");

  String get $plsInputAddressSearch => super.get("pls_input_address_search");

  String get $noFoundData => super.get("no_found_data");

  String get $searchBrand => super.get("search_brand");

  String get $checkedOut => super.get("checked_out");

  String get $scanQr => super.get("scan_qr");

  String get $checkIn => super.get("check_in");

  String get $moveCameraCheckIn => super.get("move_camera_check_in");

  String get $editImage => super.get("edit_image");

  String get $verifyPhoneDescription => super.get("verify_phone_description");

  String get $verifyPhoneSuccess => super.get("verify_phone_success");

  String get $verifyPhoneFailed => super.get("verify_phone_failed");

  String get $exit => super.get("exit");

  String get $acumulation => super.get("acumulation");

  String get $order => super.get("order");

  String get $schedule => super.get("schedule");

  String get $maintenance => super.get("maintenance");

  String get $assistant => super.get("assistant");

  String get $service => super.get("service");

  String get $wheel => super.get("wheel");

  String get $giftBox => super.get("gift_box");

  String get $tutorial => super.get("tutorial");

  String get $prize => super.get("prize");

  String get $serviceCharge => super.get("service_charge");

  String get $accumulatedPoint => super.get("accumulated_point");

  String get $relatedFormula => super.get("related_formula");

  String get $noTimeLimit => super.get("no_time_limit");

  String get $numberlessthan1 => super.get("numberlessthan1");

  String get $headquarters => super.get("headquarters");

  String get $course => super.get("course");

  String get $myCourse => super.get("my_course");

  String get $courseCategory => super.get("course_category");

  String get $registNow => super.get("regist_now");

  String get $learnNow => super.get("learn_now");

  String get $mustPhoneAuthentic => super.get("must_phone_authentic");

  String get $phoneAuthentic => super.get("phone_authentic");

  String get $orderDetailTitle => super.get("order_detail_title");

  String get $follow => super.get("follow");

  String get $implementation => super.get("implementation");

  String get $selectLocation => super.get("select_location");

  String get $selectThisLocation => super.get("select_this_location");

  String get $scanRewardCode => super.get("scan_reward_code");

  String get $openGrantRights => super.get("open_grant_rights");

  String get $inputYourReward => super.get("input_your_reward");

  String get $apply => super.get("apply");

  String get $emptyRewardCode => super.get("empty_reward_code");

  String get $invitation => super.get("invitation");

  String get $affiliate => super.get("affiliate");

  String $invitationTitle(List<String> args) =>
      super.get("invitation_title", args);

  String get $shareMessNull => super.get("share_mess_null");

  String get $share => super.get("share");

  String get $copy => super.get("copy");

  String get $copyLinkSuccess => super.get("copy_link_success");

  String get $lastStepToFinish => super.get("last_step_to_finish");

  String get $hiLetUsKnowYou => super.get("hi_let_us_know_you");

  String get $firstName => super.get("first_name");

  String get $lastName => super.get("last_name");

  String get $start => super.get("start");

  String get $fullnameRequired => super.get("fullname_required");

  String get $accumulatePoints => super.get("accumulate_points");

  String get $giveCodeToStaff => super.get("give_code_to_staff");

  String $maxLevel(List<String> args) => super.get("max_level", args);

  String $hiLetUsKnowYourDob(List<String> args) =>
      super.get("hi_let_us_know_your_dob", args);

  String get $dmyBirthday => super.get("dmy_birthday");

  String get $nameIsRequired => super.get("name_is_required");

  String get $birthdayIsRequired => super.get("birthday_is_required");

  String get $privilegeReward => super.get("privilege_reward");

  String get $addRewardSuccess => super.get("add_reward_success");

  String get $referral => super.get("referral");

  String get $referralSucc => super.get("referral_succ");

  String get $referralBy => super.get("referral_By");

  String get $inputReferral => super.get("input_referral");

  String get $yourReferralCode => super.get("your_referral_code");

  String get $plsInputReferralCode => super.get("pls_input_referral_code");

  String get $ordered => super.get("ordered");

  String get $paymentFailed => super.get("payment_failed");

  String get $tryAgian => super.get("try_agian");

  String $haveOrderUnpaid(List<String> args) =>
      super.get("have_order_unpaid", args);

  String get $view => super.get("view");

  String get $unpaid => super.get("unpaid");

  String get $orderBuy => super.get("order_buy");

  String get $readAllMsg => super.get("read_all_msg");

  String get $copyReward => super.get("copy_reward");

  String get $copyRewardHelp => super.get("copy_reward_help");

  String get $numberOfReferrals => super.get("number_of_referrals");

  String get $accumulatedPointsFromReferral =>
      super.get("accumulated_points_from_referral");

  String get $prepareToSeat => super.get("prepare_to_seat");

  String get $accumulationSuccessfully =>
      super.get("accumulation_successfully");

  String get $accumulationNotSuccessfully =>
      super.get("accumulation_not_successfully");

  String get $evaluationCriteriaAreRequired =>
      super.get("evaluation_criteria_are_required");

  String get $questionCancelOrder => super.get("question_cancel_order");

  String get $orderCancelSucc => super.get("order_cancel_succ");

  String get $orderStatus => super.get("order_status");

  String get $orderCanceled => super.get("order_canceled");

  String get $orderConfirm => super.get("order_confirm");

  String get $orderConfirmMessage => super.get("order_confirm_message");

  String get $deliveryTo => super.get("delivery_to");

  String get $expectedDelivery => super.get("expected_delivery ");

  String get $formTransportation => super.get("form_transportation");

  String get $receiveAt => super.get("receive_at");

  String get $name => super.get("name");

  String get $provisional => super.get("provisional");

  String get $rewardCode => super.get("reward_code");

  String get $agency => super.get("agency");

  String get $deliveryCost => super.get("delivery_cost");

  String get $billInfo => super.get("bill_info");

  String get $receiverInfo => super.get("receiver_info");

  String get $transferInfo => super.get("transfer_info");

  String get $bankBranch => super.get("bank_branch");

  String get $accountHolder => super.get("account_holder");

  String get $accountNumber => super.get("account_number");

  String get $cashOnDelivery => super.get("cash_on_delivery");

  String get $thankForPurchase => super.get("thank_for_purchase");

  String get $succTransaction => super.get("succ_transaction");

  String get $codeOrders => super.get("code_orders");

  String get $paymentTime => super.get("payment_time");

  String get $addressNotFound => super.get("address_not_found");

  String get $locationNotSetup => super.get("location_not_setup");

  String get $formula => super.get("formula");

  String get $formulaSearch => super.get("formula_search");

  String get $purchaseHistory => super.get("purchase_history");

  String get $homeReviewMess => super.get("home_review_mess");

  String get $givePhoneNumber => super.get("give_phone_number");

  String get $givePhoneNumberCorrect => super.get("give_phone_number_correct");

  String get $giveBirthday => super.get("give_birthday");

  String get $tokenDoesNotExist => super.get("token_does_not_exist");

  String get $iosVersionNotSupport => super.get("ios_version_not_support");

  String $wheelTurn(List<String> args) => super.get("wheel_turn", args);

  String $receiveGift(List<String> args) => super.get("receive_gift", args);

  String get $wheelMessageEmpty => super.get("wheel_message_empty");

  String get $useRewardSucc => super.get("use_reward_succ");

  String get $rewardHasUsed => super.get("reward_has_used");

  String get $rewardConsideration => super.get("reward_consideration");

  String get $outTurn => super.get("out_turn");

  String get $missReward => super.get("miss_reward");

  String get $wheelReward => super.get("wheel_reward");

  String $comeBackGetPlayTurn(List<String> args) =>
      super.get("come_back_get_play_turn", args);

  String get $yourRewardIs => super.get("your_reward_is");

  String get $playContinue => super.get("play_continue");

  String $luckyphoneWon(List<String> args) => super.get("luckyphone_won", args);

  String get $addGiftToReward => super.get("add_gift_to_reward");

  String get $continueFindGift => super.get("continue_find_gift");

  String get $assign => super.get("assign");

  String get $oneMore => super.get("one_more");

  String get $haftCup => super.get("haft_cup");

  String get $lostTurn => super.get("lost_turn");

  String get $drinkTwoCup => super.get("drink_two_cup");

  String get $supernaculum => super.get("supernaculum");

  String get $drinkLess => super.get("drink_less");

  String get $turnedInto => super.get("turned_into");

  String get $chooseBrand => super.get("choose_brand");

  String get $alreadyUsed => super.get("already_used");

  String get $alreadyUsedMess => super.get("already_used_mess");

  String get $iHasUsed => super.get("i_has_used");

  String get $confirmSucc => super.get("confirm_succ");

  String get $unmarkCode => super.get("unmark_code");

  String get $makeSureUnmarkCode => super.get("make_sure_unmark_code");

  String get $serviceArea => super.get("service_area");

  String get $serviceAresAreNotSetUp =>
      super.get("service_ares_are_not_set_up");

  String get $spacesAreNotSetUp => super.get("spaces_are_not_set_up");

  String get $bookingHen => super.get("booking_hen");

  String get $haveSpaPackageUnused => super.get("have_spa_package_unused");

  String $haveOrderUncompleted(List<String> args) =>
      super.get("have_order_uncompleted", args);

  String get $callStore => super.get("call_store");

  String get $phoneNotSetup => super.get("phone_not_setup");

  String get $oldest => super.get("oldest");

  String get $mostPoints => super.get("most_points");

  String get $lowestPoint => super.get("lowest_point");

  String get $spendingFromFriends => super.get("spending_from_friends");

  String get $usedRewards => super.get("used_rewards");

  String get $completedProfile => super.get("completed_profile");

  String get $other => super.get("other");

  String get $linkNotSetup => super.get("link_not_setup");

  String get $orderUncompleted => super.get("order_uncompleted");

  String get $exitApp => super.get("exit_app");

  String get $exitAppMess => super.get("exit_app_mess");

  String get $districtHint => super.get("district_hint");

  String get $provinceHint => super.get("province_hint");

  String get $restaurantClosest => super.get("restaurant_closest");

  String get $selectStore => super.get("select_store");

  String $pleaseSelect(List<String> args) => super.get("please_select", args);

  String get $receiveGiftsImmediately => super.get("receive_gifts_immediately");

  String get $getOldGiveNewRequest => super.get("get_old_give_new_request");

  String get $considerOldProductPrice =>
      super.get("consider_old_product_price");

  String get $selectYourProduct => super.get("select_your_product");

  String $request(List<String> args) => super.get("request", args);

  String get $inputDeviceInfoExchange =>
      super.get("input_device_info_exchange");

  String get $sendRequest => super.get("send_request");

  String get $productType => super.get("product_type");

  String get $color => super.get("color");

  String $pleaseInput(List<String> args) => super.get("please_input", args);

  String get $successfully => super.get("successfully");

  String get $getRewardCode => super.get("get_reward_code");

  String $select(List<String> args) => super.get("select", args);

  String get $applyAtCounter => super.get("apply_at_counter");

  String get $applyOnApp => super.get("apply_on_app");

  String get $appointmentDate => super.get("appointment_date");

  String get $time => super.get("time");

  String get $typeService => super.get("type_service");

  String get $serviceDetails => super.get("service_details");

  String get $customerInfo => super.get("customer_info");

  String get $buyNow => super.get("buy_now");

  String get $receivedAt => super.get("received_at");

  String get $networdMessage => super.get("netword_message");

  String get $bookingTitle => super.get("booking_title");

  String get $buttonCurrentText => super.get("button_current_text");

  String get $bookingInfoTitle => super.get("booking_info_title");

  String get $bookingConfirmText => super.get("booking_confirm_text");

  String get $bookingSuccessAnnouncement =>
      super.get("booking_success_announcement");

  String get $bookingReceipt => super.get("booking_receipt");

  String get $bookingReserveInfo => super.get("booking_reserve_info");

  String get $bookingSuccessMessage => super.get("booking_success_message");

  String get $sale => super.get("sale");

  String get $onlineConsultationError => super.get("online_consultation_error");

  String get $supportCenter => super.get("support_center");

  String get $hotRewards => super.get("hot_rewards");

  String get $hotProducts => super.get("hot_products");

  String get $notFoundData => super.get("not_found_data");

  String get $brandSearchHint => super.get("brand_search_hint");

  String get $mustInputUserPass => super.get("must_input_user_pass");

  String get $takeIamgeSucc => super.get("take_iamge_succ");

  String get $canIHelpYou => super.get("can_i_help_you");

  String get $yourProblem => super.get("your_problem");

  String get $companyInfo => super.get("company_info");

  String get $requestHelpIssues => super.get("request_help_issues");

  String get $serviceManuals => super.get("service_manuals");

  String get $safeSecure => super.get("safe_secure");

  String get $forBeginners => super.get("for_beginners");

  String get $termsPolicy => super.get("terms_policy");

  String get $promotions => super.get("promotions");

  String get $fanpageNotSetup => super.get("fanpage_not_setup");

  String get $freeShip => super.get("free_ship");

  String get $openZalo => super.get("open_zalo");

  String get $validFor => super.get("valid_for");

  String get $weWillCall => super.get("we_will_call");

  String get $optToZalo => super.get("opt_to_zalo");

  String get $iUnderstand => super.get("i_understand");

  String get $paymentAmount => super.get("payment_amount");

  String get $dial => super.get("dial");

  String get $notDriveMess => super.get("not_drive_mess");

  String get $giftMessageEmpty => super.get("gift_message_empty");

  String get $outTurnGift => super.get("out_turn_gift");

  String $turnLeftGift(List<String> args) => super.get("turn_left_gift", args);

  String $turnLeftKiller(List<String> args) =>
      super.get("turn_left_killer", args);

  String get $updateWheelReward => super.get("update_wheel_reward");

  String get $watchOnYoutube => super.get("watch_on_youtube");

  String get $chooseCategory => super.get("choose_category");

  String get $fail => super.get("fail");

  String $notAbleVerifyPhoneOn(List<String> args) =>
      super.get("not_able_verify_phone_on", args);

  String get $connectSocialAccount => super.get("connect_social_account");

  String get $plsProvideEmail => super.get("pls_provide_email");

  String get $plsProvideCorrectEmail => super.get("pls_provide_correct_email");

  String $unconnectedSocialAccountSucc(List<String> args) =>
      super.get("unconnected_social_account_succ", args);

  String $connectedSocialAccountSucc(List<String> args) =>
      super.get("connected_social_account_succ", args);

  String get $free => super.get("free");

  String get $plsTakePhone => super.get("pls_take_phone");

  String get $otpExpired => super.get("otp_expired");

  String get $resendOtpCode => super.get("resend_otp_code");

  String get $rulePlay => super.get("rule_play");

  String get $prizeStructure => super.get("prize_structure");

  String get $specialPrize => super.get("special_prize");

  String get $normalPrize => super.get("normal_prize");

  String get $noOneWin => super.get("no_one_win");

  String $gameClose(List<String> args) => super.get("game_close", args);

  String get $japanese => super.get("japanese");

  String get $enterPhoneRequestMessage =>
      super.get("enter_phone_request_message");

  String get $findInformationSupport => super.get("find_information_support");

  String get $hi => super.get("hi");

  String get $canWeHelpYou => super.get("can_we_help_you");

  String get $requestSupport => super.get("request_support");

  String get $selectSubjectInterested => super.get("select_subject_interested");

  String get $mayYouInteresting => super.get("may_you_interesting");

  String get $applicationInfo => super.get("application_info");

  String $version(List<String> args) => super.get("version", args);

  String $buildNumber(List<String> args) => super.get("build_number", args);

  String get $topUpHistory => super.get("top_up_history");

  String $accumulateViaPhone(List<String> args) =>
      super.get("accumulate_via_phone", args);

  String get $orderTitle => super.get("order_title");
  String get $orderHistory => super.get("history_order");

  String get $reviewsProduct => super.get("reviews_product");

  String get $productFavorite => super.get("product_favorite");

  String get $rewardMine => super.get("reward_mine");

  String get $historyOfPoints => super.get("history_of_points");
  String get $profileWarranty => super.get("profile_warranty");
  String get $addressBook => super.get("address_book");

  String $rewardOf(List<String> arg) => super.get("reward_of", arg);

  String get $invitationApp => super.get("invitation_app");

  String get $customerType => super.get("customer_type");

  String get $requestVerifyphoneMess1 => super.get("request_verifyphone_mess1");

  String get $requestVerifyphoneMess2 => super.get("request_verifyphone_mess2");

  String get $requestVerifyphoneWarning =>
      super.get("request_verifyphone_warning");

  String get $changePassword => super.get("change_password");

  String get $inviteInstall => super.get("invitation");

  String get $extension => super.get("extension");

  String get $classify => super.get("classify");

  String get $memberLevel => super.get("member_level");

  String get $privacyTitle => super.get("privacy_title");

  String get $privacyAgree => super.get("privacy_agree");

  String get $suffixPrivacyTitle => super.get("suffix_privacy_title");

  String get $prefixPrivacyTitle => super.get("prefix_privacy_title");

  String get $genderRequired => super.get("gender_required");

  String $hiLetUsKnowYourGender(List<String> args) =>
      super.get("hi_let_us_know_your_gender", args);

  String get $doYouWantDeleteCurrentAvatar =>
      super.get("do_you_want_delete_current_avatar");

  String get $deletedCurrentAvatar => super.get("deleted_current_avatar");

  String get $deleteCurrentAvatar => super.get("delete_current_avatar");

  String get $updateInfoSuccess => super.get("update_info_success");

  String get $viewAll => super.get("view_all");

  String get $inputYourEventCode => super.get("input_your_event_code");

  String get $btnBookingTitle => super.get("btn_booking_title");

  String get $restaurantList => super.get("restaurant_list");

  String get $selectProvinceMessage => super.get("select_province_message");

  String get $selectDistrictMessage => super.get("select_district_message");

  String get $selectWardMessage => super.get("select_ward_message");

  String get $selectLocationArea => super.get("select_location_area");

  String get $specificAddress => super.get("specific_address");

  String get $hintAddress => super.get("hint_address");

  String get $inputSpecificAddress => super.get("input_specific_address");

  String get $province => super.get("province");

  String get $district => super.get("district");

  String get $wards => super.get("wards");

  String get $searchAddress => super.get("search_address");
  String get $chooseAddressTitle => super.get("choose_address_title");
  String get $hintSearchProvince => super.get("hint_search_province");
  String get $hintSearchDistrict => super.get("hint_search_district");
  String get $hintSearchWard => super.get("hint_search_ward");
  String get $messageEmptyProvince => super.get("message_empty_province");
  String get $messageEmptyDistrict => super.get("message_empty_district");
  String get $messageEmptyWard => super.get("message_empty_ward");
  String get $provinceHeader => super.get("province_header");
  String get $districtHeader => super.get("district_header");
  String get $wardHeader => super.get("ward_header");
  String get $countriesEmpty => super.get("countries_empty");

  String get $sendReviewSuccess => super.get("send_review_success");
  String get $yourFeeling => super.get("your_feeling");
  String get $enterYourReview => super.get("enter_your_review");
  String get $addImage => super.get("add_image");
  String $maximumImage(List<String> args) => super.get("maximum_image", args);
  String get $sendReviewText => super.get("send_review_text");
  String get $category => super.get("category");
  String get $rateOrderItem => super.get("rate_order_item");
  String get $buyAgain => super.get("buy_again");
  String get $seeDetail => super.get("see_detail");
  String get $variant => super.get("variant");
  String get $yourFavorite => super.get("your_favorite");
  String get $addToFavorite => super.get("add_to_favorite");
  String get $removeFavorite => super.get("remove_favorite");
  String get $myAddressTitle => super.get("my_address_title");
  String get $addNewAddress => super.get("add_new_address");
  String get $addAddressTitle => super.get("add_address_title");
  String get $fullName => super.get("full_name");
  String get $phoneNumber => super.get("phone_number");
  String get $ward => super.get("ward");
  String get $addressDetailTitle => super.get("address_detail_title");
  String get $enterAddressDetail => super.get("enter_address_detail");
  String get $addressDetailContent => super.get("address_detail_content");
  String get $setAddressDefault => super.get("set_address_default");
  String get $helpDeliveryQuick => super.get("help_delivery_quick");
  String get $selectSite => super.get("select_site");
  String get $shippingMethodTitle => super.get("shipping_method_title");
  String get $selectAddressInMap => super.get("select_address_in_map");
  String $pleaseEnterInformation(List<String> arg) =>
      super.get("please_enter_information", arg);
  String get $typeDelivery => super.get("type_delivery");
  String get $receiveAtStore => super.get("receive_at_store");
  String get $delivery => super.get("delivery");
  String get $timeReceiveAtStore => super.get("time_receive_at_store");
  String get $addressReceiveAtStore => super.get("address_receive_at_store");
  String get $change => super.get("change");
  String get $orderDetailList => super.get("order_detail_list");
  String get $paymentMethod => super.get("payment_method");
  String get $paymentPanelTitle => super.get("payment_panel_title");
  String get $subTotalPrice => super.get("sub_total_price");
  String get $totalPayment => super.get("total_payment");
  String get $orderButton => super.get("order_button");
  String get $addVoucher => super.get("add_voucher");
  String get $shippingMethod => super.get("shipping_method");
  String get $noteTitle => super.get("note_title");
  String get $ifHave => super.get("if_have");
  String get $noteForSeller => super.get("note_for_seller");
  String get $shippingPrice => super.get("shipping_price");
  String get $salePrice => super.get("sale_price");
  String get $addressReceive => super.get("address_receive");
  String get $orderSuccess => super.get("order_success");
  String get $backToHome => super.get("back_to_home");
  String get $thankYou => super.get("thank_you");
  String get $updateInformation => super.get("update_information");
  String get $outStock => super.get("out_stock");
  String get $paymentMenthod => super.get("payment_menthod");
  String get $copyAccountNumber => super.get("copy_account_number");
  String get $recommentdation => super.get("recommentdation");
  String $chooseAnything(List<String> args) =>
      super.get("choose_anything", args);
  String get $timeReceive => super.get("time_receive");
  String get $temporaryPrice => super.get("temporary_price");
  String get $total => super.get("total");
  String get $staffContactLater => super.get("staff_contact_later");
  String get $provideNameTocontinue => super.get("provide_name_tocontinue");
  String get $selectAnotherPaymentMethod =>
      super.get("select_another_payment_method");
  String get $provideAddressTocontinue =>
      super.get("provide_address_tocontinue");
  String get $purchaseQuestion => super.get("purchase_question");
  String get $orderFail => super.get("order_fail");
  String get $thanksForPurchase => super.get("thanks_for_purchase");
  String get $paymentFail => super.get("payment_fail");
  String get $orderId => super.get("order_id");
  String get $amountMoney => super.get("amount_money");
  String get $wedn => super.get("wedn");
  String get $thurs => super.get("thurs");
  String get $roomPrice => super.get("room_price");
  String get $night => super.get("night");
  String get $couponDetail => super.get("coupon_detail");
  String get $applyOnline => super.get("apply_online");
  String get $noLitmitTime => super.get("no_litmit_time");
  String get $timeToUsed => super.get("time_to_used");
  String get $enterAddressBook => super.get("enter_address_book");
  String get $discountShippingPrice => super.get("discount_shipping_price");
  String get $paid => super.get("paid");
  String get $selectShippingMenthod => super.get("select_shipping_menthod");
  String get $comeBack => super.get("come_back");
  String get $productDetail => super.get("product_detail");
  String get $branch => super.get("branch");
  String get $stock => super.get("stock");
  String $quantity(List<String> args) => super.get("quantity", args);
  String $availableProducts(List<String> args) =>
      super.get("available_products", args);
  String get $removeProductFromCart => super.get("remove_product_from_cart");
  String get $addToCart => super.get("add_to_cart");
  String get $introduction => super.get("introduction");
  String get $description => super.get("description");
  String get $notFoundAddress => super.get("not_found_address");
  String $plsChoose(List<String> args) => super.get("pls_choose", args);
  String get $deliveryAddress => super.get("delivery_address");
  String get $search => super.get("search");
  String get $range => super.get("range");
  String get $noContentDisplay => super.get("no_content_display");
  String get $hotSearch => super.get("hot_search");
  String get $searchProduct => super.get("search_product");
  String get $searchSortTitle => super.get("search_sort_title");
  String get $searchFilterTitle => super.get("search_filter_title");
  String get $productPageTitle => super.get("product_page_title");
  String get $productFilterTitle => super.get("product_filter_title");
  String get $vnPayCode01 => super.get("vn_pay_code01");
  String get $vnPayCode04 => super.get("vn_pay_code04");
  String get $vnPayCode05 => super.get("vn_pay_code05");
  String get $vnPayCode13 => super.get("vn_pay_code13");
  String get $vnPayCode07 => super.get("vn_pay_code07");
  String get $vnPayCode09 => super.get("vn_pay_code09");
  String get $vnPayCode10 => super.get("vn_pay_code10");
  String get $vnPayCode11 => super.get("vn_pay_code11");
  String get $vnPayCode12 => super.get("vn_pay_code12");
  String get $vnPayCode51 => super.get("vn_pay_code51");
  String get $vnPayCode65 => super.get("vn_pay_code65");
  String get $vnPayCode08 => super.get("vn_pay_code08");
  String get $vnPayCode99 => super.get("vn_pay_code99");
  String get $vnPayCode259 => super.get("vn_pay_code259");
  String $applyCoupon(List<String> args) => super.get("apply_coupon", args);
  String get $complete => super.get("complete");
  String get $viewCart => super.get("view_cart");
  String get $searchAgency => super.get("search_agency");
  String get $createAddress => super.get("create_address");
  String get $saveAddress => super.get("save_address");
  String get $productInfo => super.get("product_info");
  String get $maximum => super.get("maximum");
  String get $updateCart => super.get("update_cart");
  String get $addCart => super.get("add_cart");
  String get $menuNotSetUp => super.get("menu_not_set_up");

  String get $addRewardSucc => super.get("add_reward_succ");

  String $minimumAmount(List<String> args) => super.get("minimum_amount", args);

  String get $transferInformation => super.get("transfer_information");

  String get $content => super.get("content");

  String get $bankNumber => super.get("bank_number");

  String get $inputPricePayment => super.get("input_price_payment");

  String get $bookingRoom => super.get("booking_room");

  String get $bookingCar => super.get("booking_car");

  String get $listOfPoints => super.get("list_of_points");

  String get $useAccumulate => super.get("use_accumulate");

  String get $enterPhone => super.get("enter_phone");

  String get $applyAtZalo => super.get("apply_at_zalo");

  String get $applyAtPos => super.get("apply_at_pos");

  String get $hasUsed => super.get("has_used");

  String get $detailImage => super.get("detail_image");

  String get $getNow => super.get("get_now");

  String get $wantToUseGiftCard => super.get("want_to_use_gift_card");

  String get $spendGiftCardSuccess => super.get("spend_gift_card_success");

  String get $yourTopupBalance => super.get("your_topup_balance");

  String get $locationInfo => super.get("location_info");

  String get $locationName => super.get("location_name");

  String get $requestAccumulate => super.get("request_accumulate");

  String get $accumulateInfo => super.get("accumulate_info");

  String get $billNumber => super.get("bill_number");

  String get $waitingChecking => super.get("waiting_checking");

  String get $sendAccumulateInfo => super.get("send_accumulate_info");

  String get $backHome => super.get("back_home");

  String get $requestOrderId => super.get("request_order_id");

  String get $requestAmount => super.get("request_amount");

  String get $applyBuying => super.get("apply_buying");
  String get $bonusRedemption => super.get("bonus_redemption");
  String get $ratingOrderCompleted => super.get("rating_order_completed");
  String get $useUntil => super.get("use_until");
  String get $shareYourMind => super.get("share_your_mind");
  String get $youRated => super.get("you_rated");
  String get $viewRating => super.get("view_rating");
  String get $noImage => super.get("no_image");
  String get $emptyEventCode => super.get("empty_event_code");
  String get $waitUntilUploadSuccess => super.get("wait_until_upload_success");
  String get $viewShippingInfo => super.get("view_shipping_info");
  String get $ratingAfterOrder => super.get("rating_after_order");
  String get $receiveAddress => super.get("receive_address");
  String get $shippingInfo => super.get("shipping_info");
  String get $payment => super.get("payment");
  String get $shippingCost => super.get("shipping_cost");

  String get $perform => super.get("perform");
  String get $surveyForm => super.get("survey_form");
  String get $nameOfBranch => super.get("name_of_branch");
  String get $survaySucc => super.get("survay_succ");
  String get $thanksForSurvay => super.get("thanks_for_survay");
  String get $sendForm => super.get("send_form");
  String get $effect => super.get("effect");
  String get $messageEnterFeedbackForm =>
      super.get("message_enter_feedback_form");
  String get $feedbackAboutAgency => super.get("feedback_about_agency");
  String get $chooseAgency => super.get("choose_agency");
  String get $feedbackContent => super.get("feedback_content");
  String get $hintFeedbackContent => super.get("hint_feedback_content");
  String get $attachedImage => super.get("attached_image");
  String get $confirmDeleteImage => super.get("confirm_delete_image");
  String get $feedbackForm => super.get("feedback_form");
  String get $messageChooseAgency => super.get("message_choose_agency");
  String get $messageContentEmpty => super.get("message_content_empty");
  String get $messageImageEmpty => super.get("message_image_empty");
  String get $messageFeedbackSuccess => super.get("message_feedback_success");
  String get $messageFeedbackFail => super.get("message_feedback_fail");

  String get $cod => super.get("cod");
  String get $paymentViaPayoo => super.get("payment_via_payoo");
  String get $completeOrder => super.get("complete_order");
  String get $waiting => super.get("waiting");
  String get $topupHistoryDetailTitle =>
      super.get("topup_history_detail_title");
  String $messageSelectTopupPackage(List<String> args) =>
      super.get("message_select_topup_package", args);
  String get $pleaseEnterName => super.get("please_enter_name");
  String get $announcement => super.get("announcement");
  String get $pleaseEnterPhoneNumber => super.get("please_enter_phone_number");
  String get $messageChargeMoney => super.get("message_charge_money");
  String get $messageCreateTopupSuccess =>
      super.get("message_create_topup_success");
  String get $success => super.get("success");
  String get $messageUnsuccess => super.get("message_unsuccess");
  String get $cancelOrder => super.get("cancel_order");
  String get $firstPagerTitle => super.get("first_pager_title");
  String get $secondPagerTitle => super.get("second_pager_title");
  String get $chargeButtonText => super.get("charge_button_text");
  String get $topupBalance => super.get("topup_balance");
  String get $topup => super.get("topup");
  String get $topupStatus => super.get("topup_status");
  String get $getAmount => super.get("get_amount");
  String get $spend => super.get("spend");
  String get $forOther => super.get("for_other");
  String get $timeCharge => super.get("time_charge");
  String get $chargeFor => super.get("charge_for");
  String get $yourInfo => super.get("your_info");
  String get $giver => super.get("giver");
  String get $giftCardDetail => super.get("gift_card_detail");
  String $package(List<String> args) => super.get("package", args);
  String get $messageChargeFail => super.get("message_charge_fail");
  String get $userPhoneGiftCardOther => super.get("user_phone_gift_card_other");
  String get $timeGive => super.get("time_give");
  String get $topUpPackage => super.get("top_up_package");
  String get $moneyCharge => super.get("money_charge");
  String get $prepaid => super.get("prepaid");
  String get $inputPhoneNubmer => super.get("input_phone_nubmer");
  String get $phoneNotExist => super.get("phone_not_exist");
  String get $feedbackTitle => super.get("feedback_title");

  String get $area => super.get("area");

  String $paymentViaPaymentMenthodSucc(List<String> args) =>
      super.get("payment_via_payment_menthod_succ", args);

  String $paymentViaPaymentMenthodFail(List<String> args) =>
      super.get("payment_via_payment_menthod_fail", args);

  String get $cancelOrders => super.get("cancel_orders");

  String get $contactAndAdvise => super.get("contact_and_advise");
  String get $confirmedInterest => super.get("confirmed_interest");
  String get $confirmChooseDate => super.get("confirm_choose_date");
  String get $warrantyPageTitle => super.get("warranty_page_title");
  String get $current => super.get("current");
  String get $warrantyCard => super.get("warranty_card");
  String $warrantyCountDay(List<String> args) =>
      super.get("warranty_count_day", args);
  String $warrantyStartDay(List<String> args) =>
      super.get("warranty_start_day", args);
  String $warrantyExpiredDay(List<String> args) =>
      super.get("warranty_expired_day", args);
  String get $imeiNumber => super.get("imei_number");
  String get $date => super.get("date");
  String get $updatingTheLatestData => super.get("updating_the_latest_data");
  String get $PleaseWaitaSecond => super.get("please_wait_a_second");



  String get $individual => super.get("individual");
  String get $organization => super.get("organization");
  String get $please_select_the_login => super.get("please_select_the_login");
  String get $login_for_individuals => super.get("login_for_individuals");
  String get $please_enter_otp => super.get("please_enter_otp");
  String get $send_otp => super.get("send_otp");
  String get $you_did_not_receive_the_code => super.get("you_did_not_receive_the_code");
  String get $just_one_more_step_to_complete => super.get("just_one_more_step_to_complete");
  String get $login_for_organization => super.get("login_for_organization");
  String get $email_address => super.get("email_address");
  String get $password => super.get("password");
  String get $forgot_password => super.get("forgot_password");
  String get $do_not_have_an_account => super.get("do_not_have_an_account");
  String get $registration_for_organizations => super.get("registration_for_organizations");
  String get $confirm_password => super.get("confirm_password");
  String get $hide => super.get("hide");
  String get $presently => super.get("presently");
  String get $do_you_already_have_an_account => super.get("do_you_already_have_an_account");
  String get $hi_organization => super.get("hi_organization");
  String get $organization_name => super.get("organization_name");
  String get $contact_name => super.get("contact_name");
  String get $contact_email => super.get("contact_email");
  String get $please_your_password => super.get("please_your_password");
  String get $back_to_login => super.get("back_to_login");
  String get $enter_the_password => super.get("enter_the_password");
  String get $password_characters => super.get("password_characters");
  String get $confirm_new_password => super.get("confirm_new_password");
  String get $reset_assword => super.get("reset_assword");
  String get $startup => super.get("startup");
  String get $investors => super.get("investors");
  String get $experts => super.get("experts");
  String get $incubator_program => super.get("incubator_program");
  String get $state_program => super.get("state_program");
  String get $information_communication => super.get("information_communication");
  String get $partner_ecosystem => super.get("partner_ecosystem");
  String get $innovation_map => super.get("innovation_map");
  String get $popular_rank => super.get("popular_rank");
  String get $connect_with => super.get("connect_with");
  String get $nursery => super.get("nursery");
  String get $looking_for_startups => super.get("looking_for_startups");
  String get $typical_startups => super.get("typical_startups");
  String get $typical_investor => super.get("typical_investor");
  String get $typical_expert => super.get("typical_expert");
  String get $favourite => super.get("favourite");
  String get $appointment_schedule => super.get("appointment_schedule");
  String get $evaluate => super.get("evaluate");
  String get $field_of_activity => super.get("field_of_activity");
  String get $type_of_business_model => super.get("type_of_business_model");
  String get $founded_year => super.get("founded_year");
  String get $contact_info => super.get("contact_info");
  String get $company_address => super.get("company_address");
  String get $address_dot => super.get("address_dot");
  String get $member_hoip => super.get("member_hoip");
  String get $achievements_and_awards_achieved => super.get("achievements_and_awards_achieved");
  String get $time_hoip => super.get("time_hoip");
  String get $investment_round => super.get("investment_round");
  String get $worth => super.get("worth");
  String get $comment => super.get("comment");
  String get $write_a_review => super.get("write_a_review");
  String get $tap_the_star_to_rate => super.get("tap_the_star_to_rate");
  String get $add_actual_images => super.get("add_actual_images");
  String get $to_5_pictures => super.get("to_5_pictures");
  String get $foreign_program => super.get("foreign_program");
  String get $main_advantage => super.get("main_advantage");
  String get $startup_invested => super.get("startup_invested");
  String get $saved_to_favorites => super.get("saved_to_favorites");
  String get $canceled_from_favorites => super.get("canceled_from_favorites");



}
