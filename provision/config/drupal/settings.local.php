<?php

// Mostly you should just have to change these lines
$dev_email = "YOUR_EMAIL";
    
$db_name = "wsupg";
$db_user = "root";
$db_pass = "1234";
    
###############################################################################################################
/*                                      DO NOT EDIT BELOW THIS LINE                                          */
###############################################################################################################
    
$site_mail = 'dev@wsupg.net';
$conf['site_name'] = 'wsupg.dev';

$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'driver' => 'mysql',
      'username' => $db_user,
      'password' => $db_pass,
      'port' => '',
      'host' => 'localhost',
      'database' => $db_name,
      'prefix' => '',
    ),
  ),
);

# If you set $cookie_domain, *.wsupg.dev will use the same cookie so you can
# stay logged in across subdomains (languages).  If that's not
# important, than you can just leave it commented out.
$cookie_domain = '.wsupg.dev';
ini_set('session.cookie_lifetime', 0); // for persistent_login module

ini_set('memory_limit', '1000M'); // Set high for things like sending vbo

$conf['file_temporary_path'] = "/tmp";
$conf['faq_path'] = 'faq'; // This should be set in db after upgrade, but required during upgrade process

$conf['wsuser_num_users_to_remind_per_run'] = 4; // Limit how many of these we send
$conf['wsuser_last_notavailable_reminder_period'] = 60 * 60 * 24 * 600;  // 600 days
$conf['wsuser_become_available_users_max'] = 4;

// Items that are for staging only
$conf['stage_file_proxy_origin'] = 'https://www.warmshowers.org';

$conf['pm_email_notify_from'] = "$site_mail";
$conf['ws_pm_email_notify_mandrill_reply_to_domain'] = 'reply.wsupg.net';
$conf['mandrill_incoming_canonical_url'] = '';
$conf['mandrill_incoming_failure_forward_email'] = "$dev_email";

$conf['reroute_email_enable'] = TRUE;
$conf['reroute_email_address'] = "$dev_email";

$conf['uc_paypal_wps_debug_ipn'] = TRUE;
$conf['uc_paypal_wps_server'] = 'https://www.sandbox.paypal.com/cgi-bin/webscr';
$conf['uc_stripe_testmode'] = TRUE;

$conf['wsuser_num_users_to_remind_per_run'] = 1; // Limit how many of these we send

$conf['error_level'] = 2;  // Make sure all errors on screen
$conf['preprocess_css'] = 0;
$conf['preprocess_js'] = 0;

$conf['user_location_adv_cycling_kmz'] = 'http://' . $conf['site_name'] . '/sites/all/modules/dev/wsmap/kml/ACA_Cycling_Routes.kmz?a';

$update_free_access = TRUE;

+$conf['robotstxt'] = "# Now that we are using the robotstxt module
+# we must ensure that we DO NOT have a robots.txt in the web root.
+# This will be created by the robotstxt module instead.
+#
+# To make sure that local sites disallow robots,
+# we can override the contents of the file here:
+User-agent: *
+Disallow: /
+";

/**
 * Include the private settings config.
 */
$private_settings = dirname(__FILE__) . '/settings.private.php';
if (file_exists($private_settings)) {
  include $private_settings;
}
