BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Account_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Account_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_time"	datetime NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "admin_interface_theme" (
	"id"	integer NOT NULL,
	"name"	varchar(50) NOT NULL UNIQUE,
	"active"	bool NOT NULL,
	"title"	varchar(50) NOT NULL,
	"title_visible"	bool NOT NULL,
	"logo"	varchar(100) NOT NULL,
	"logo_visible"	bool NOT NULL,
	"css_header_background_color"	varchar(10) NOT NULL,
	"css_header_text_color"	varchar(10) NOT NULL,
	"css_header_link_color"	varchar(10) NOT NULL,
	"css_header_link_hover_color"	varchar(10) NOT NULL,
	"css_module_background_color"	varchar(10) NOT NULL,
	"css_module_text_color"	varchar(10) NOT NULL,
	"css_module_link_color"	varchar(10) NOT NULL,
	"css_module_link_hover_color"	varchar(10) NOT NULL,
	"css_module_rounded_corners"	bool NOT NULL,
	"css_generic_link_color"	varchar(10) NOT NULL,
	"css_generic_link_hover_color"	varchar(10) NOT NULL,
	"css_save_button_background_color"	varchar(10) NOT NULL,
	"css_save_button_background_hover_color"	varchar(10) NOT NULL,
	"css_save_button_text_color"	varchar(10) NOT NULL,
	"css_delete_button_background_color"	varchar(10) NOT NULL,
	"css_delete_button_background_hover_color"	varchar(10) NOT NULL,
	"css_delete_button_text_color"	varchar(10) NOT NULL,
	"list_filter_dropdown"	bool NOT NULL,
	"related_modal_active"	bool NOT NULL,
	"related_modal_background_color"	varchar(10) NOT NULL,
	"related_modal_rounded_corners"	bool NOT NULL,
	"logo_color"	varchar(10) NOT NULL,
	"title_color"	varchar(10) NOT NULL,
	"recent_actions_visible"	bool NOT NULL,
	"favicon"	varchar(100) NOT NULL,
	"related_modal_background_opacity"	varchar(5) NOT NULL,
	"env_name"	varchar(50) NOT NULL,
	"env_color"	varchar(10) NOT NULL,
	"env_visible_in_header"	bool NOT NULL,
	"env_visible_in_favicon"	bool NOT NULL,
	"related_modal_close_button_visible"	bool NOT NULL,
	"language_chooser_active"	bool NOT NULL,
	"language_chooser_display"	varchar(10) NOT NULL,
	"list_filter_sticky"	bool NOT NULL,
	"form_pagination_sticky"	bool NOT NULL,
	"form_submit_sticky"	bool NOT NULL,
	"css_module_background_selected_color"	varchar(10) NOT NULL,
	"css_module_link_selected_color"	varchar(10) NOT NULL,
	"logo_max_height"	smallint unsigned NOT NULL CHECK("logo_max_height" >= 0),
	"logo_max_width"	smallint unsigned NOT NULL CHECK("logo_max_width" >= 0),
	"foldable_apps"	bool NOT NULL,
	"language_chooser_control"	varchar(20) NOT NULL,
	"list_filter_highlight"	bool NOT NULL,
	"list_filter_removal_links"	bool NOT NULL,
	"show_fieldsets_as_tabs"	bool NOT NULL,
	"show_inlines_as_tabs"	bool NOT NULL,
	"css_generic_link_active_color"	varchar(10) NOT NULL,
	"collapsible_stacked_inlines"	bool NOT NULL,
	"collapsible_stacked_inlines_collapsed"	bool NOT NULL,
	"collapsible_tabular_inlines"	bool NOT NULL,
	"collapsible_tabular_inlines_collapsed"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "Account_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"first_name"	varchar(150) NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	"date_joined"	datetime NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"username"	varchar(50) NOT NULL UNIQUE,
	"phone"	varchar(14) NOT NULL UNIQUE,
	"is_active"	bool NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_superuser"	bool NOT NULL,
	"type"	varchar(10) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_doctor" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"specialization"	varchar(100) NOT NULL,
	"qualification"	varchar(100) NOT NULL,
	"experience"	varchar(100) NOT NULL,
	"fees"	varchar(100) NOT NULL,
	"user_id"	bigint,
	"image"	varchar(100) NOT NULL,
	"hospital_id"	bigint,
	FOREIGN KEY("hospital_id") REFERENCES "Hospital_hospital"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_personalassistant" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"description"	text NOT NULL,
	"active"	bool NOT NULL,
	"doctor_id"	bigint NOT NULL,
	"user_id"	bigint,
	FOREIGN KEY("doctor_id") REFERENCES "Doctor_doctor"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_operatingday" (
	"id"	integer NOT NULL,
	"day"	varchar(100) NOT NULL UNIQUE,
	"doctor_id"	bigint NOT NULL,
	FOREIGN KEY("doctor_id") REFERENCES "Doctor_doctor"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Appointment_appointment" (
	"id"	integer NOT NULL,
	"date"	date NOT NULL,
	"time"	time NOT NULL,
	"message"	text NOT NULL,
	"doctor_id"	bigint NOT NULL,
	"estimated_time_required"	integer,
	"patient_id"	bigint,
	FOREIGN KEY("patient_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("doctor_id") REFERENCES "Doctor_doctor"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_operatinghour" (
	"id"	integer NOT NULL,
	"start_time"	varchar(100) NOT NULL,
	"end_time"	varchar(100) NOT NULL,
	"day_id"	bigint NOT NULL,
	FOREIGN KEY("day_id") REFERENCES "Doctor_operatingday"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Appointment_waiting" (
	"id"	integer NOT NULL,
	"date"	date NOT NULL,
	"time_in"	time NOT NULL,
	"estimated_time_required"	integer NOT NULL,
	"priority"	integer,
	"patient_id"	bigint NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Hospital_hospital" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"address"	varchar(100) NOT NULL,
	"phone_number"	varchar(100) NOT NULL,
	"email"	varchar(100) NOT NULL,
	"image"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_tag" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_doctor_tags" (
	"id"	integer NOT NULL,
	"doctor_id"	bigint NOT NULL,
	"tag_id"	bigint NOT NULL,
	FOREIGN KEY("doctor_id") REFERENCES "Doctor_doctor"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("tag_id") REFERENCES "Doctor_tag"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Patient_patient" (
	"id"	integer NOT NULL,
	"full_name"	varchar(100) NOT NULL,
	"dob"	date NOT NULL,
	"gender"	varchar(100) NOT NULL,
	"user_id"	bigint,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Patient_medicalrecord" (
	"id"	integer NOT NULL,
	"chronic_illness"	text,
	"acute_illness"	text,
	"allergies"	text,
	"family_history"	text,
	"current_medication"	text,
	"past_medication"	text,
	"prescription"	text,
	"patient_id"	bigint NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "Patient_patient"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Doctor_access" (
	"id"	integer NOT NULL,
	"card_uid"	varchar(500) UNIQUE,
	"pin"	varchar(6) NOT NULL UNIQUE,
	"user_id"	bigint UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "Account_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2023-09-20 18:03:20.705725');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0002_remove_content_type_name','2023-09-20 18:03:20.708403');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2023-09-20 18:03:20.712942');
INSERT INTO "django_migrations" VALUES (4,'auth','0002_alter_permission_name_max_length','2023-09-20 18:03:20.715546');
INSERT INTO "django_migrations" VALUES (5,'auth','0003_alter_user_email_max_length','2023-09-20 18:03:20.717409');
INSERT INTO "django_migrations" VALUES (6,'auth','0004_alter_user_username_opts','2023-09-20 18:03:20.719350');
INSERT INTO "django_migrations" VALUES (7,'auth','0005_alter_user_last_login_null','2023-09-20 18:03:20.721202');
INSERT INTO "django_migrations" VALUES (8,'auth','0006_require_contenttypes_0002','2023-09-20 18:03:20.721724');
INSERT INTO "django_migrations" VALUES (9,'auth','0007_alter_validators_add_error_messages','2023-09-20 18:03:20.723523');
INSERT INTO "django_migrations" VALUES (10,'auth','0008_alter_user_username_max_length','2023-09-20 18:03:20.725315');
INSERT INTO "django_migrations" VALUES (11,'auth','0009_alter_user_last_name_max_length','2023-09-20 18:03:20.727299');
INSERT INTO "django_migrations" VALUES (12,'auth','0010_alter_group_name_max_length','2023-09-20 18:03:20.729639');
INSERT INTO "django_migrations" VALUES (13,'auth','0011_update_proxy_permissions','2023-09-20 18:03:20.732177');
INSERT INTO "django_migrations" VALUES (14,'auth','0012_alter_user_first_name_max_length','2023-09-20 18:03:20.734456');
INSERT INTO "django_migrations" VALUES (15,'Account','0001_initial','2023-09-20 18:03:20.738606');
INSERT INTO "django_migrations" VALUES (16,'Doctor','0001_initial','2023-09-20 18:03:20.739776');
INSERT INTO "django_migrations" VALUES (17,'admin','0001_initial','2023-09-20 18:03:20.743217');
INSERT INTO "django_migrations" VALUES (18,'admin','0002_logentry_remove_auto_add','2023-09-20 18:03:20.747687');
INSERT INTO "django_migrations" VALUES (19,'admin','0003_logentry_add_action_flag_choices','2023-09-20 18:03:20.750575');
INSERT INTO "django_migrations" VALUES (20,'admin_interface','0001_initial','2023-09-20 18:03:20.752370');
INSERT INTO "django_migrations" VALUES (21,'admin_interface','0002_add_related_modal','2023-09-20 18:03:20.762201');
INSERT INTO "django_migrations" VALUES (22,'admin_interface','0003_add_logo_color','2023-09-20 18:03:20.766709');
INSERT INTO "django_migrations" VALUES (23,'admin_interface','0004_rename_title_color','2023-09-20 18:03:20.768810');
INSERT INTO "django_migrations" VALUES (24,'admin_interface','0005_add_recent_actions_visible','2023-09-20 18:03:20.771588');
INSERT INTO "django_migrations" VALUES (25,'admin_interface','0006_bytes_to_str','2023-09-20 18:03:20.793304');
INSERT INTO "django_migrations" VALUES (26,'admin_interface','0007_add_favicon','2023-09-20 18:03:20.796661');
INSERT INTO "django_migrations" VALUES (27,'admin_interface','0008_change_related_modal_background_opacity_type','2023-09-20 18:03:20.800795');
INSERT INTO "django_migrations" VALUES (28,'admin_interface','0009_add_enviroment','2023-09-20 18:03:20.806339');
INSERT INTO "django_migrations" VALUES (29,'admin_interface','0010_add_localization','2023-09-20 18:03:20.811923');
INSERT INTO "django_migrations" VALUES (30,'admin_interface','0011_add_environment_options','2023-09-20 18:03:20.824349');
INSERT INTO "django_migrations" VALUES (31,'admin_interface','0012_update_verbose_names','2023-09-20 18:03:20.826854');
INSERT INTO "django_migrations" VALUES (32,'admin_interface','0013_add_related_modal_close_button','2023-09-20 18:03:20.830302');
INSERT INTO "django_migrations" VALUES (33,'admin_interface','0014_name_unique','2023-09-20 18:03:20.833388');
INSERT INTO "django_migrations" VALUES (34,'admin_interface','0015_add_language_chooser_active','2023-09-20 18:03:20.836511');
INSERT INTO "django_migrations" VALUES (35,'admin_interface','0016_add_language_chooser_display','2023-09-20 18:03:20.839768');
INSERT INTO "django_migrations" VALUES (36,'admin_interface','0017_change_list_filter_dropdown','2023-09-20 18:03:20.843041');
INSERT INTO "django_migrations" VALUES (37,'admin_interface','0018_theme_list_filter_sticky','2023-09-20 18:03:20.846124');
INSERT INTO "django_migrations" VALUES (38,'admin_interface','0019_add_form_sticky','2023-09-20 18:03:20.852919');
INSERT INTO "django_migrations" VALUES (39,'admin_interface','0020_module_selected_colors','2023-09-20 18:03:20.862425');
INSERT INTO "django_migrations" VALUES (40,'admin_interface','0021_file_extension_validator','2023-09-20 18:03:20.864982');
INSERT INTO "django_migrations" VALUES (41,'admin_interface','0022_add_logo_max_width_and_height','2023-09-20 18:03:20.871372');
INSERT INTO "django_migrations" VALUES (42,'admin_interface','0023_theme_foldable_apps','2023-09-20 18:03:20.875341');
INSERT INTO "django_migrations" VALUES (43,'admin_interface','0024_remove_theme_css','2023-09-20 18:03:20.879215');
INSERT INTO "django_migrations" VALUES (44,'admin_interface','0025_theme_language_chooser_control','2023-09-20 18:03:20.882888');
INSERT INTO "django_migrations" VALUES (45,'admin_interface','0026_theme_list_filter_highlight','2023-09-20 18:03:20.886488');
INSERT INTO "django_migrations" VALUES (46,'admin_interface','0027_theme_list_filter_removal_links','2023-09-20 18:03:20.890170');
INSERT INTO "django_migrations" VALUES (47,'admin_interface','0028_theme_show_fieldsets_as_tabs_and_more','2023-09-20 18:03:20.897326');
INSERT INTO "django_migrations" VALUES (48,'admin_interface','0029_theme_css_generic_link_active_color','2023-09-20 18:03:20.901758');
INSERT INTO "django_migrations" VALUES (49,'admin_interface','0030_theme_collapsible_stacked_inlines_and_more','2023-09-20 18:03:20.915551');
INSERT INTO "django_migrations" VALUES (50,'sessions','0001_initial','2023-09-20 18:03:20.917282');
INSERT INTO "django_migrations" VALUES (51,'Account','0002_user_type','2023-09-20 19:11:06.338600');
INSERT INTO "django_migrations" VALUES (52,'Doctor','0002_operatingdays_doctor_user_alter_doctor_image_and_more','2023-09-20 19:11:06.356089');
INSERT INTO "django_migrations" VALUES (53,'Appointment','0001_initial','2023-09-20 19:11:06.361498');
INSERT INTO "django_migrations" VALUES (54,'Doctor','0003_rename_operatingdays_operatingday_and_more','2023-09-20 19:11:50.823242');
INSERT INTO "django_migrations" VALUES (55,'Appointment','0002_appointment_estimated_time_required_and_more','2023-09-21 12:28:32.381586');
INSERT INTO "django_migrations" VALUES (56,'Hospital','0001_initial','2023-09-21 12:28:32.383026');
INSERT INTO "django_migrations" VALUES (57,'Doctor','0004_tag_doctor_hospital_doctor_tags','2023-09-21 12:28:32.393425');
INSERT INTO "django_migrations" VALUES (58,'Patient','0001_initial','2023-09-21 12:28:32.406624');
INSERT INTO "django_migrations" VALUES (59,'Doctor','0005_access','2023-09-21 12:51:16.238971');
INSERT INTO "django_content_type" VALUES (1,'admin_interface','theme');
INSERT INTO "django_content_type" VALUES (2,'admin','logentry');
INSERT INTO "django_content_type" VALUES (3,'auth','permission');
INSERT INTO "django_content_type" VALUES (4,'auth','group');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'Account','user');
INSERT INTO "django_content_type" VALUES (8,'Doctor','doctor');
INSERT INTO "django_content_type" VALUES (9,'Doctor','operatingday');
INSERT INTO "django_content_type" VALUES (10,'Doctor','personalassistant');
INSERT INTO "django_content_type" VALUES (11,'Doctor','operatinghour');
INSERT INTO "django_content_type" VALUES (12,'Appointment','appointment');
INSERT INTO "django_content_type" VALUES (13,'Doctor','tag');
INSERT INTO "django_content_type" VALUES (14,'Hospital','hospital');
INSERT INTO "django_content_type" VALUES (15,'Patient','patient');
INSERT INTO "django_content_type" VALUES (16,'Patient','medicalrecord');
INSERT INTO "django_content_type" VALUES (17,'Appointment','waiting');
INSERT INTO "django_content_type" VALUES (18,'Doctor','access');
INSERT INTO "auth_permission" VALUES (1,1,'add_theme','Can add Theme');
INSERT INTO "auth_permission" VALUES (2,1,'change_theme','Can change Theme');
INSERT INTO "auth_permission" VALUES (3,1,'delete_theme','Can delete Theme');
INSERT INTO "auth_permission" VALUES (4,1,'view_theme','Can view Theme');
INSERT INTO "auth_permission" VALUES (5,2,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (6,2,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (7,2,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (8,2,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (9,3,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (10,3,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (11,3,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (12,3,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (13,4,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (14,4,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (15,4,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (16,4,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (26,7,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (27,7,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (28,7,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (29,8,'add_doctor','Can add doctor');
INSERT INTO "auth_permission" VALUES (30,8,'change_doctor','Can change doctor');
INSERT INTO "auth_permission" VALUES (31,8,'delete_doctor','Can delete doctor');
INSERT INTO "auth_permission" VALUES (32,8,'view_doctor','Can view doctor');
INSERT INTO "auth_permission" VALUES (33,9,'add_operatingdays','Can add operating days');
INSERT INTO "auth_permission" VALUES (34,9,'change_operatingdays','Can change operating days');
INSERT INTO "auth_permission" VALUES (35,9,'delete_operatingdays','Can delete operating days');
INSERT INTO "auth_permission" VALUES (36,9,'view_operatingdays','Can view operating days');
INSERT INTO "auth_permission" VALUES (37,10,'add_personalassistant','Can add personal assistant');
INSERT INTO "auth_permission" VALUES (38,10,'change_personalassistant','Can change personal assistant');
INSERT INTO "auth_permission" VALUES (39,10,'delete_personalassistant','Can delete personal assistant');
INSERT INTO "auth_permission" VALUES (40,10,'view_personalassistant','Can view personal assistant');
INSERT INTO "auth_permission" VALUES (41,11,'add_operatinghours','Can add operating hours');
INSERT INTO "auth_permission" VALUES (42,11,'change_operatinghours','Can change operating hours');
INSERT INTO "auth_permission" VALUES (43,11,'delete_operatinghours','Can delete operating hours');
INSERT INTO "auth_permission" VALUES (44,11,'view_operatinghours','Can view operating hours');
INSERT INTO "auth_permission" VALUES (45,12,'add_appointment','Can add appointment');
INSERT INTO "auth_permission" VALUES (46,12,'change_appointment','Can change appointment');
INSERT INTO "auth_permission" VALUES (47,12,'delete_appointment','Can delete appointment');
INSERT INTO "auth_permission" VALUES (48,12,'view_appointment','Can view appointment');
INSERT INTO "auth_permission" VALUES (49,9,'add_operatingday','Can add operating day');
INSERT INTO "auth_permission" VALUES (50,9,'change_operatingday','Can change operating day');
INSERT INTO "auth_permission" VALUES (51,9,'delete_operatingday','Can delete operating day');
INSERT INTO "auth_permission" VALUES (52,9,'view_operatingday','Can view operating day');
INSERT INTO "auth_permission" VALUES (53,11,'add_operatinghour','Can add operating hour');
INSERT INTO "auth_permission" VALUES (54,11,'change_operatinghour','Can change operating hour');
INSERT INTO "auth_permission" VALUES (55,11,'delete_operatinghour','Can delete operating hour');
INSERT INTO "auth_permission" VALUES (56,11,'view_operatinghour','Can view operating hour');
INSERT INTO "auth_permission" VALUES (57,13,'add_tag','Can add tag');
INSERT INTO "auth_permission" VALUES (58,13,'change_tag','Can change tag');
INSERT INTO "auth_permission" VALUES (59,13,'delete_tag','Can delete tag');
INSERT INTO "auth_permission" VALUES (60,13,'view_tag','Can view tag');
INSERT INTO "auth_permission" VALUES (61,14,'add_hospital','Can add hospital');
INSERT INTO "auth_permission" VALUES (62,14,'change_hospital','Can change hospital');
INSERT INTO "auth_permission" VALUES (63,14,'delete_hospital','Can delete hospital');
INSERT INTO "auth_permission" VALUES (64,14,'view_hospital','Can view hospital');
INSERT INTO "auth_permission" VALUES (65,15,'add_patient','Can add patient');
INSERT INTO "auth_permission" VALUES (66,15,'change_patient','Can change patient');
INSERT INTO "auth_permission" VALUES (67,15,'delete_patient','Can delete patient');
INSERT INTO "auth_permission" VALUES (68,15,'view_patient','Can view patient');
INSERT INTO "auth_permission" VALUES (69,16,'add_medicalrecord','Can add medical record');
INSERT INTO "auth_permission" VALUES (70,16,'change_medicalrecord','Can change medical record');
INSERT INTO "auth_permission" VALUES (71,16,'delete_medicalrecord','Can delete medical record');
INSERT INTO "auth_permission" VALUES (72,16,'view_medicalrecord','Can view medical record');
INSERT INTO "auth_permission" VALUES (73,17,'add_waiting','Can add waiting');
INSERT INTO "auth_permission" VALUES (74,17,'change_waiting','Can change waiting');
INSERT INTO "auth_permission" VALUES (75,17,'delete_waiting','Can delete waiting');
INSERT INTO "auth_permission" VALUES (76,17,'view_waiting','Can view waiting');
INSERT INTO "auth_permission" VALUES (77,18,'add_access','Can add access');
INSERT INTO "auth_permission" VALUES (78,18,'change_access','Can change access');
INSERT INTO "auth_permission" VALUES (79,18,'delete_access','Can delete access');
INSERT INTO "auth_permission" VALUES (80,18,'view_access','Can view access');
INSERT INTO "admin_interface_theme" VALUES (1,'USWDS',1,'Django administration',0,'',1,'#112E51','#FFFFFF','#FFFFFF','#E1F3F8','#205493','#FFFFFF','#FFFFFF','#E1F3F8',1,'#205493','#0071BC','#205493','#112E51','#FFFFFF','#CD2026','#981B1E','#FFFFFF',0,1,'#000000',1,'#FFFFFF','#FFFFFF',1,'','0.8','','#E74C3C',1,1,1,1,'code',1,0,0,'#FFFFCC','#FFFFFF',100,400,1,'default-select',1,0,0,0,'#29B864',0,1,0,1);
INSERT INTO "django_session" VALUES ('sw0beutxetu7v5fqx2sp2t0u8ez7y8dl','.eJxVjMsOwiAQRf-FtSG8EZfu_QYyMINUDSSlXRn_3TbpQrf3nHPfLMK61LgOmuOE7MIkO_1uCfKT2g7wAe3eee5tmafEd4UfdPBbR3pdD_fvoMKoW229d6DPWvignadCWWYQGByRk8EYVFgcORApS63BFGUFgbCbCarIwD5f3Bs4MA:1qj1Zz:UttIC3SRSh_A5LOQkfCyouK1nIJOqwueHHLXurgISBI','2023-10-04 18:05:39.610982');
INSERT INTO "Account_user" VALUES (1,'pbkdf2_sha256$600000$r6sJdhDmvo2vVdrj3DGM60$+uCoHYGoOEw+nv7Y0Lre4xT+96QoObrbJyTiksahEbQ=','2023-09-20 18:05:39.609942','','','2023-09-20 18:04:10.455286','admin@asc.com','admin','',1,1,1,'patient');
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "Account_user_groups_user_id_group_id_dab5ccc9_uniq" ON "Account_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "Account_user_groups_user_id_b27ad110" ON "Account_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Account_user_groups_group_id_d3895c74" ON "Account_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "Account_user_user_permissions_user_id_permission_id_de385f15_uniq" ON "Account_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "Account_user_user_permissions_user_id_48cb4e40" ON "Account_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Account_user_user_permissions_permission_id_e40e0e47" ON "Account_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "Doctor_doctor_user_id_94d9c8e7" ON "Doctor_doctor" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_personalassistant_doctor_id_2e54d8f1" ON "Doctor_personalassistant" (
	"doctor_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_personalassistant_user_id_614d6b40" ON "Doctor_personalassistant" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_operatingdays_doctor_id_87f8b59f" ON "Doctor_operatingday" (
	"doctor_id"
);
CREATE INDEX IF NOT EXISTS "Appointment_appointment_doctor_id_5b220a42" ON "Appointment_appointment" (
	"doctor_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_operatinghours_day_id_84a308ec" ON "Doctor_operatinghour" (
	"day_id"
);
CREATE INDEX IF NOT EXISTS "Appointment_appointment_patient_id_ee62c42a" ON "Appointment_appointment" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "Appointment_waiting_patient_id_b3f8f904" ON "Appointment_waiting" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_doctor_hospital_id_f6a8dae9" ON "Doctor_doctor" (
	"hospital_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "Doctor_doctor_tags_doctor_id_tag_id_5a27405f_uniq" ON "Doctor_doctor_tags" (
	"doctor_id",
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_doctor_tags_doctor_id_5d5ca2ef" ON "Doctor_doctor_tags" (
	"doctor_id"
);
CREATE INDEX IF NOT EXISTS "Doctor_doctor_tags_tag_id_86aebea1" ON "Doctor_doctor_tags" (
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "Patient_patient_user_id_0e3d0d5e" ON "Patient_patient" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "Patient_medicalrecord_patient_id_fedd7f41" ON "Patient_medicalrecord" (
	"patient_id"
);
COMMIT;
