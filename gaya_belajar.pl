% Sistem Pakar Gaya Belajar

% Fakta tentang karakteristik gaya belajar berdasarkan jawaban pengguna
suka_mendengar(X) :- jawaban(X, 'Ya', mendengar1).
suka_mendengar(X) :- jawaban(X, 'Ya', mendengar2).
suka_mendengar(X) :- jawaban(X, 'Ya', mendengar3).
suka_mendengar(X) :- jawaban(X, 'Ya', mendengar4).
suka_mendengar(X) :- jawaban(X, 'Ya', mendengar5).

suka_membaca(X) :- jawaban(X, 'Ya', membaca1).
suka_membaca(X) :- jawaban(X, 'Ya', membaca2).
suka_membaca(X) :- jawaban(X, 'Ya', membaca3).
suka_membaca(X) :- jawaban(X, 'Ya', membaca4).
suka_membaca(X) :- jawaban(X, 'Ya', membaca5).

suka_bergerak(X) :- jawaban(X, 'Ya', bergerak1).
suka_bergerak(X) :- jawaban(X, 'Ya', bergerak2).
suka_bergerak(X) :- jawaban(X, 'Ya', bergerak3).
suka_bergerak(X) :- jawaban(X, 'Ya', bergerak4).
suka_bergerak(X) :- jawaban(X, 'Ya', bergerak5).

% Menghitung jumlah jawaban "Ya" untuk setiap kategori
jumlah_ya_audio(X, Count) :- aggregate_all(count, suka_mendengar(X), Count).
jumlah_ya_visual(X, Count) :- aggregate_all(count, suka_membaca(X), Count).
jumlah_ya_kinestetik(X, Count) :- aggregate_all(count, suka_bergerak(X), Count).

% Aturan untuk menentukan gaya belajar berdasarkan jumlah jawaban "Ya"
gaya_belajar(X, audio) :- jumlah_ya_audio(X, Count), Count >= 3.
gaya_belajar(X, visual) :- jumlah_ya_visual(X, Count), Count >= 3.
gaya_belajar(X, kinestetik) :- jumlah_ya_kinestetik(X, Count), Count >= 3.

% Interaksi dengan pengguna
start :- 
    write('Selamat datang di sistem pakar gaya belajar!'), nl,
    write('Silakan jawab setiap pertanyaan dengan "Ya" atau "Tidak".'), nl,

    % Pertanyaan kategori Audio
    ask(mendengar1, 'Apakah Anda lebih mudah memahami materi saat dijelaskan secara verbal?'),
    ask(mendengar2, 'Apakah Anda lebih mudah memahami instruksi saat dijelaskan oleh orang lain?'),
    ask(mendengar3, 'Saat perlu petunjuk untuk bepergian, apakah Anda bertanya arah ke orang lain?'),
    ask(mendengar4, 'Jika mengajari orang lain, apakah Anda lebih nyaman memberikan penjelasan secara lisan?'),
    ask(mendengar5, 'Ketika mempelajari sesuatu yang baru, apakah Anda lebih suka mendengarkan penjelasan daripada membaca?'),

    % Pertanyaan kategori Visual
    ask(membaca1, 'Apakah Anda lebih mudah memahami informasi dalam bentuk diagram atau grafik?'),
    ask(membaca2, 'Apakah Anda lebih mudah memahami instruksi saat membaca buku panduan?'),
    ask(membaca3, 'Saat perlu petunjuk untuk bepergian, apakah Anda melihat peta atau denah?'),
    ask(membaca4, 'Jika mengajari orang lain, apakah Anda lebih nyaman menuliskan instruksi untuk mereka?'),
    ask(membaca5, 'Ketika mempelajari sesuatu yang baru, apakah Anda lebih suka melihat gambar atau video daripada mendengarkan penjelasan?'),

    % Pertanyaan kategori Kinestetik
    ask(bergerak1, 'Apakah Anda lebih cepat memahami sesuatu dengan mencoba langsung?'),
    ask(bergerak2, 'Apakah Anda lebih mudah memahami instruksi saat mempraktikkannya secara langsung?'),
    ask(bergerak3, 'Saat perlu petunjuk untuk bepergian, apakah Anda menggunakan kompas dan langsung mengikutinya?'),
    ask(bergerak4, 'Jika mengajari orang lain, apakah Anda lebih nyaman memperagakan contoh langsung?'),
    ask(bergerak5, 'Ketika mempelajari sesuatu yang baru, apakah Anda lebih suka mencoba dan mempraktikannya daripada hanya mendengarkan atau melihat?'),

    % Menentukan gaya belajar
    write('Menentukan gaya belajar Anda...'), nl,
    (gaya_belajar(user, Style) -> 
        write('Gaya belajar Anda adalah: '), write(Style), nl;
        write('Tidak dapat menentukan gaya belajar, coba jawab lebih banyak "Ya".'), nl).

% Fungsi untuk menanyakan dan menyimpan jawaban
ask(Topic, Question) :-
    write(Question), nl,
    read(Answer),
    (Answer == 'Ya' -> assert(jawaban(user, 'Ya', Topic)); assert(jawaban(user, 'Tidak', Topic))).