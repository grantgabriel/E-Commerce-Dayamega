## Cara Mulai Download Repository (Sekali saja)

-   Buka Command Prompt dan arahkan ke Folder dimana project akan disimpan.
-   Ketik `git clone https://github.com/grantgabriel/E-Commerce-Dayamega.git` dan tunggu laravel siap di install.
-   Ketik `git checkout <nama_branch>` untuk pindah ke branch masing-masing. Misal kamu pelangi maka ketik `git checkout pelangi`.
-   Copy file `.env.example` menjadi file `.env`.
-   Lakukan command

    ```
    composer install
    ```

-   Generate key dengan command

    ```
    php artisan key:generate
    ```

-   Jalankan server dengan command

    ```
    php artisan serve
    ```

-   Tutorial Lengkap ada [disini](https://stackoverflow.com/questions/38602321/cloning-laravel-project-from-github).

Project ini bersifat closed-sourced dibuat oleh Kelompok 5.
