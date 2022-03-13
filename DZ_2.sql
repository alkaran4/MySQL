/*1. MySQL установлен на компьютер. 
 * Создадим фал my.cnf в DBeaver:*/
 * [mysql]
 * user=root
 * password=****
 /* сохраним файл в папку windows.
 
 2.*/
 CREATE DATABASE IF NOT EXISTS users
 USE users
 CREATE TABLES profile (id SERIAl, name VARCHAR(100))
 
 /* 3. 
 Создаем базу данных, создаем в ней таблицу.
 Создаем вторую базу данных
 Выходим из клиента и командой "mysql sample < example.sql" делаем дамп
  */
 