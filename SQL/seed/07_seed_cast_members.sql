-- =====================================================
-- CAST_MEMBER - COMPLETE WITH DIRECT IDs
-- =====================================================

-- MOVIE 1: INCEPTION (title_id = 1)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(1, 1, 1, 'دام کاب', 'Dom Cobb', 1),
(1, 2, 1, 'آرتور', 'Arthur', 2),
(1, 3, 2, 'آریادنه', 'Ariadne', 3),
(1, 4, 1, 'ایمز', 'Eames', 4),
(1, 5, 1, 'سایتو', 'Saito', 5),
(1, 6, 1, 'رابرت فیشر', 'Robert Fischer', 6),
(1, 7, 1, 'مایلز', 'Miles', 7),
(1, 8, 2, 'مال', 'Mal', 8);

-- MOVIE 2: THE DARK KNIGHT (title_id = 2)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(2, 11, 1, 'بروس وین / بتمن', 'Bruce Wayne / Batman', 1),
(2, 12, 1, 'جوکر', 'Joker', 2),
(2, 13, 1, 'هاروی دنت', 'Harvey Dent', 3),
(2, 14, 2, 'ریچل داز', 'Rachel Dawes', 4),
(2, 15, 1, 'جیم گوردون', 'Jim Gordon', 5),
(2, 16, 1, 'لوسیوس فاکس', 'Lucius Fox', 6),
(2, 7, 1, 'آلفرد پنی‌ورث', 'Alfred Pennyworth', 7);

-- MOVIE 3: PULP FICTION (title_id = 3)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(3, 17, 1, 'وینسنت وگا', 'Vincent Vega', 1),
(3, 18, 1, 'جولز وینفیلد', 'Jules Winnfield', 2),
(3, 19, 2, 'میا والاس', 'Mia Wallace', 3),
(3, 20, 1, 'باچ کولیج', 'Butch Coolidge', 4),
(3, 21, 1, 'مارسلوس والاس', 'Marsellus Wallace', 5),
(3, 22, 1, 'گرگ', 'The Wolf', 6);

-- MOVIE 4: FORREST GUMP (title_id = 4)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(4, 24, 1, 'فارست گامپ', 'Forrest Gump', 1),
(4, 25, 2, 'جنی کوران', 'Jenny Curran', 2),
(4, 26, 1, 'سروان دن تیلور', 'Lieutenant Dan Taylor', 3),
(4, 27, 1, 'بابا بلو', 'Bubba Blue', 4),
(4, 28, 2, 'خانم گامپ', 'Mrs. Gump', 5);

-- MOVIE 5: THE MATRIX (title_id = 5)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(5, 31, 1, 'نئو', 'Neo', 1),
(5, 32, 1, 'مورفئوس', 'Morpheus', 2),
(5, 33, 2, 'ترینیتی', 'Trinity', 3),
(5, 34, 1, 'مأمور اسمیت', 'Agent Smith', 4),
(5, 35, 1, 'سایفر', 'Cypher', 5);

-- MOVIE 6: TITANIC (title_id = 6)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(6, 1, 1, 'جک داوسون', 'Jack Dawson', 1),
(6, 38, 2, 'رز دویت بوکاتر', 'Rose DeWitt Bukater', 2),
(6, 39, 1, 'کالدون هاکلی', 'Caledon Hockley', 3),
(6, 40, 2, 'مولی براون', 'Molly Brown', 4),
(6, 41, 2, 'روت دویت بوکاتر', 'Ruth DeWitt Bukater', 5);

-- MOVIE 7: GLADIATOR (title_id = 7)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(7, 44, 1, 'ماکسیموس دسیموس مریدیوس', 'Maximus Decimus Meridius', 1),
(7, 45, 1, 'کمودوس', 'Commodus', 2),
(7, 46, 2, 'لوسیللا', 'Lucilla', 3),
(7, 47, 1, 'پروکسیمو', 'Proximo', 4),
(7, 48, 1, 'مارکوس اورلیوس', 'Marcus Aurelius', 5);

-- MOVIE 8: PARASITE (title_id = 8)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(8, 50, 1, 'کیم کی-تک', 'Kim Ki-taek', 1),
(8, 51, 1, 'پارک دونگ-ایک', 'Park Dong-ik', 2),
(8, 52, 2, 'یون-کیو', 'Yeon-kyo', 3),
(8, 53, 1, 'کیم کی-وو', 'Kim Ki-woo', 4),
(8, 54, 2, 'کیم کی-جونگ', 'Kim Ki-jung', 5);

-- MOVIE 9: OPPENHEIMER (title_id = 9)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(9, 6, 1, 'جی. رابرت اوپنهایمر', 'J. Robert Oppenheimer', 1),
(9, 57, 2, 'کیتی اوپنهایمر', 'Kitty Oppenheimer', 2),
(9, 58, 1, 'لزلی گرووز', 'Leslie Groves', 3),
(9, 59, 1, 'لوییس استراوس', 'Lewis Strauss', 4),
(9, 60, 2, 'جین تاتلاک', 'Jean Tatlock', 5),
(9, 61, 1, 'ارنست لارنس', 'Ernest Lawrence', 6),
(9, 62, 1, 'دیوید هیل', 'David Hill', 7),
(9, 63, 1, 'نیلز بور', 'Niels Bohr', 8);

-- MOVIE 10: THE SOCIAL NETWORK (title_id = 10)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(10, 64, 1, 'مارک زاکربرگ', 'Mark Zuckerberg', 1),
(10, 65, 1, 'ادواردو ساورین', 'Eduardo Saverin', 2),
(10, 66, 1, 'شان پارکر', 'Sean Parker', 3),
(10, 67, 1, 'کامرون و تایلر وینکلووس', 'Cameron and Tyler Winklevoss', 4),
(10, 68, 2, 'اریکا آلبرایت', 'Erica Albright', 5),
(10, 69, 2, 'کریستی', 'Christy', 6);

-- SERIES 1: GAME OF THRONES (title_id = 11)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(11, 73, 1, 'تیریون لنیستر', 'Tyrion Lannister', 1),
(11, 74, 2, 'سرسی لنیستر', 'Cersei Lannister', 2),
(11, 75, 2, 'دنریس تارگرین', 'Daenerys Targaryen', 3),
(11, 76, 1, 'جان اسنو', 'Jon Snow', 4),
(11, 77, 2, 'سانسا استارک', 'Sansa Stark', 5),
(11, 78, 2, 'آریا استارک', 'Arya Stark', 6),
(11, 79, 1, 'جیمی لنیستر', 'Jaime Lannister', 7),
(11, 80, 1, 'پیتر بلیش', 'Petyr Baelish', 8),
(11, 81, 1, 'ند استارک', 'Ned Stark', 9),
(11, 82, 1, 'رابرت براتیون', 'Robert Baratheon', 10),
(11, 83, 2, 'برین تارث', 'Brienne of Tarth', 11),
(11, 84, 1, 'سمول تارلی', 'Samwell Tarly', 12),
(11, 85, 1, 'برن استارک', 'Bran Stark', 13),
(11, 86, 1, 'هودور', 'Hodor', 14),
(11, 87, 1, 'برون', 'Bronn', 15),
(11, 88, 1, 'واریس', 'Varys', 16),
(11, 89, 2, 'الاریا سند', 'Ellaria Sand', 17),
(11, 90, 2, 'میساندی', 'Missandei', 18);

-- SERIES 2: BREAKING BAD (title_id = 12)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(12, 94, 1, 'والتر وایت', 'Walter White', 1),
(12, 95, 1, 'جسی پینکمن', 'Jesse Pinkman', 2),
(12, 96, 2, 'اسکایلر وایت', 'Skyler White', 3),
(12, 97, 1, 'هانک شریدر', 'Hank Schrader', 4),
(12, 98, 2, 'ماری شریدر', 'Marie Schrader', 5),
(12, 99, 1, 'والتر وایت جونیور', 'Walter White Jr.', 6),
(12, 100, 1, 'سال گودمن', 'Saul Goodman', 7),
(12, 101, 1, 'مایک ارمنتراوت', 'Mike Ehrmantraut', 8),
(12, 102, 1, 'گوستاوو فرینگ', 'Gustavo Fring', 9),
(12, 103, 2, 'لیدیا رودارت-کویل', 'Lydia Rodarte-Quayle', 10),
(12, 104, 1, 'تاد آلکوئیست', 'Todd Alquist', 11);

-- SERIES 3: STRANGER THINGS (title_id = 13)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(13, 108, 2, 'جویس بایرز', 'Joyce Byers', 1),
(13, 109, 1, 'جیم هاپر', 'Jim Hopper', 2),
(13, 110, 2, 'ایلون', 'Eleven', 3),
(13, 111, 1, 'مایک ویلر', 'Mike Wheeler', 4),
(13, 112, 1, 'داستین هندرسون', 'Dustin Henderson', 5),
(13, 113, 1, 'لوکاس سینکلر', 'Lucas Sinclair', 6),
(13, 114, 1, 'ویل بایرز', 'Will Byers', 7),
(13, 115, 2, 'مکس میفیلد', 'Max Mayfield', 8),
(13, 116, 2, 'اریکا سینکلر', 'Erica Sinclair', 9),
(13, 117, 1, 'موری بومن', 'Murray Bauman', 10),
(13, 118, 1, 'استیو هرینگتون', 'Steve Harrington', 11),
(13, 119, 2, 'رابین باکلی', 'Robin Buckley', 12);

-- SERIES 4: THE CROWN (title_id = 14)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(14, 124, 2, 'ملکه الیزابت دوم (جوان)', 'Queen Elizabeth II (young)', 1),
(14, 125, 2, 'ملکه الیزابت دوم (میانسال)', 'Queen Elizabeth II (middle)', 2),
(14, 126, 2, 'ملکه الیزابت دوم (پیر)', 'Queen Elizabeth II (older)', 3),
(14, 201, 1, 'پرنس فیلیپ (جوان)', 'Prince Philip (young)', 4),
(14, 127, 1, 'پرنس فیلیپ (میانسال)', 'Prince Philip (middle)', 5),
(14, 128, 2, 'پرنسس مارگارت (جوان)', 'Princess Margaret (young)', 6),
(14, 129, 2, 'پرنسس مارگارت (میانسال)', 'Princess Margaret (middle)', 7),
(14, 130, 1, 'پرنس چارلز (جوان)', 'Prince Charles (young)', 8),
(14, 131, 2, 'پرنسس دایانا (جوان)', 'Princess Diana (young)', 9),
(14, 132, 2, 'پرنسس دایانا (پیر)', 'Princess Diana (older)', 10),
(14, 133, 1, 'وینستون چرچیل', 'Winston Churchill', 11),
(14, 134, 1, 'پرنس فیلیپ (پیر)', 'Prince Philip (older)', 12),
(14, 135, 2, 'پرنسس مارگارت (پیر)', 'Princess Margaret (older)', 13);

-- SERIES 5: SUCCESSION (title_id = 15)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(15, 139, 1, 'لوگان روی', 'Logan Roy', 1),
(15, 140, 1, 'کندال روی', 'Kendall Roy', 2),
(15, 141, 2, 'شیو روی', 'Shiv Roy', 3),
(15, 142, 1, 'رومن روی', 'Roman Roy', 4),
(15, 143, 1, 'کانر روی', 'Connor Roy', 5),
(15, 144, 1, 'تام ومبسگانز', 'Tom Wambsgans', 6),
(15, 145, 1, 'گرگ هیرش', 'Greg Hirsch', 7),
(15, 146, 2, 'مارسیا روی', 'Marcia Roy', 8),
(15, 147, 1, 'فرانک ورنون', 'Frank Vernon', 9),
(15, 148, 2, 'ویلا فری', 'Willa Ferreyra', 10);

-- SERIES 6: DARK (title_id = 16)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(16, 152, 1, 'یوناس کانوالد', 'Jonas Kahnwald', 1),
(16, 153, 1, 'اولریش نیلسن', 'Ulrich Nielsen', 2),
(16, 154, 2, 'کاترینا نیلسن', 'Katharina Nielsen', 3),
(16, 155, 2, 'شارلوت داپلر', 'Charlotte Doppler', 4),
(16, 156, 1, 'نوح', 'Noah', 5),
(16, 157, 1, 'بارتوش تیبرمان', 'Bartosz Tiedemann', 6);

-- SERIES 7: WESTWORLD (title_id = 17)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(17, 161, 2, 'دولورس آبرناتی', 'Dolores Abernathy', 1),
(17, 162, 2, 'میو میلی', 'Maeve Millay', 2),
(17, 163, 1, 'برنارد لو', 'Bernard Lowe', 3),
(17, 164, 1, 'تدی فلوود', 'Teddy Flood', 4),
(17, 165, 1, 'مرد سیاه‌پوش', 'The Man in Black', 5),
(17, 166, 1, 'رابرت فورد', 'Robert Ford', 6),
(17, 167, 2, 'شارلوت هیل', 'Charlotte Hale', 7),
(17, 168, 1, 'استابز', 'Stubbs', 8),
(17, 169, 2, 'ترزا کالین', 'Theresa Cullen', 9);

-- SERIES 8: THE MANDALORIAN (title_id = 18)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(18, 202, 1, 'مندلورین / دین ججرین', 'The Mandalorian / Din Djarin', 1),
(18, 172, 2, 'کارا دون', 'Cara Dune', 2),
(18, 173, 1, 'گریف کارگا', 'Greef Karga', 3),
(18, 174, 1, 'مشتری', 'The Client', 4),
(18, 175, 2, 'بو-کاتان کریز', 'Bo-Katan Kryze', 5),
(18, 102, 1, 'موف گیدئون', 'Moff Gideon', 6),
(18, 178, 2, 'پلی مونتو', 'Peli Motto', 7);

-- SERIES 9: HOUSE OF THE DRAGON (title_id = 19)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(19, 201, 1, 'دیمون تارگرین', 'Daemon Targaryen', 1),
(19, 179, 2, 'رینیرا تارگرین', 'Rhaenyra Targaryen', 2),
(19, 180, 2, 'آلیسنت هایتاور', 'Alicent Hightower', 3),
(19, 181, 1, 'اتو هایتاور', 'Otto Hightower', 4),
(19, 182, 1, 'کورلیس ولاریون', 'Corlys Velaryon', 5),
(19, 183, 2, 'رینیس تارگرین', 'Rhaenys Targaryen', 6),
(19, 184, 1, 'کریستون کول', 'Criston Cole', 7),
(19, 185, 1, 'لاریس استرانگ', 'Larys Strong', 8),
(19, 186, 2, 'سارا اسنوک', 'Sarah Snook', 9);

-- SERIES 10: THE LAST OF US (title_id = 20)
INSERT INTO cast_member (title_id, person_id, role_id, char_name_fa, char_name_en, ordering) VALUES
(20, 202, 1, 'جوئل میلر', 'Joel Miller', 1),
(20, 188, 2, 'الی ویلیامز', 'Ellie Williams', 2),
(20, 189, 1, 'تامی میلر', 'Tommy Miller', 3),
(20, 190, 2, 'تس سرووپولوس', 'Tess Servopoulos', 4),
(20, 191, 2, 'سارا میلر', 'Sarah Miller', 5),
(20, 192, 1, 'فرانک', 'Frank', 6),
(20, 193, 1, 'بیل', 'Bill', 7),
(20, 194, 2, 'کاتلین', 'Kathleen', 8),
(20, 195, 1, 'پری', 'Perry', 9);