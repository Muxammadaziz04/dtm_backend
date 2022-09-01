
# DTM TEST




## API Reference

api - https://dtm-test-sayt.herokuapp.com

# Auth

#### Login

```http
  POST /login
```

| Parameter | Type                    | Description                            |
| :-------- | :---------------------- | :------------------------------------- |
| `contact` | `string or number`      | **Required**  Telefon nomer yoki email |
| `password`| `string or number`      | **Required**  Userni paroli            |

#### Register

```http
  POST /register
```

| Parameter | Type     | Description                            |
| :-------- | :------- | :------------------------------------- |
| `fullname`| `string` | **Required**. user Fullname            |
| `contact` | `string or number` | **Required**. user contact   |
| `region_id` | `uuid` | **Required**. region id                |
| `password` | `string or number` | **Required**. user password |
| `gender` | `string` | **Required**. `male yoki female`        |

# Subjects

#### Get First Subjects 

```http
  GET /firstsubject
```
| Headers | Description   |
| :------ | :------------ |
| `token` | **Required**  |

#### Get Second Subjects

```http
  GET /secondsubject/{first_subject_id}
```

| Parameter          | Type                    | Description   |
| :----------------- | :---------------------- | :------------ |
| `first_subject_id` | `uuid`                  | **Required**  | 



```http
  POST /subject
```

| Parameter          | Type                    | Description   |
| :----------------- | :---------------------- | :------------ |
| `subject_name`     | `string`                | **Required**  |

```http
  PUT /subject/{subject_id}
```

```http
  DELETE /subject/{subject_id}
```

| Parameter          | Type                    | Description   |
| :----------------- | :---------------------- | :------------ |
| `subject_id`       | `uuid`                  | **Required**  |
| `subject_name`     | `string`                |               |

# Faculties

```http
  GET /faculties/{faculty_id}
```

| Parameter          | Type                    | Description   |
| :----------------- | :---------------------- | :------------ |
| `faculty_id`       | `uuid`                  | **Required**  |

```http
  POST /faculty
```

| Parameter                | Type      | Description                             |
| :----------------------- | :-------- | :-------------------------------------- |
| `faculty_name`           | `string`  | **Required** Fakultet nomi              |
| `first_subject`          | `uuid`    | **Required** birinchi fan id si         |
| `second_subject`         | `uuid`    | **Required** ikkinchi fan id si         |
| `grant_count`            | `integer` | **Required** grant uchun joylar soni    |
| `contract_count`         | `integer` | **Required** contact uchun joylar soni  |
| `passing_score_grant`    | `number`  | **Required** grant uchun kirish bali    |
| `passing_score_contract` | `number`  | **Required** contract uchun kirish bali |
| `university_id`          | `uuid`    | **Required** universitet id si          |

```http
  PUT /faculty/{faculty_id}
```

| Parameter                | Type      | Description                             |
| :----------------------- | :-------- | :-------------------------------------- |
| `faculty_id`             | `uuid`    | **Required** Fakultet id si             |
| `faculty_name`           | `string`  | Fakultet nomi                           |
| `first_subject`          | `uuid`    | birinchi fan id si                      |
| `second_subject`         | `uuid`    | ikkinchi fan id si                      |
| `grant_count`            | `integer` | grant uchun joylar soni                 |
| `contract_count`         | `integer` | contact uchun joylar soni               |
| `passing_score_grant`    | `number`  | grant uchun kirish bali                 |
| `passing_score_contract` | `number`  | contract uchun kirish bali              |
| `university_id`          | `uuid`    | universitet id si                       |

```http
  DELETE /faculty/{faculty_id}
```

| Parameter                | Type      | Description                             |
| :----------------------- | :-------- | :-------------------------------------- |
| `faculty_id`             | `uuid`    | **Required** Fakultet id si             |

# Universities

```http
  GET /universities
```

| Query            | Type      | Description                             |
| :--------------- | :-------- | :-------------------------------------- |
| `first_subject`  | `uuid`    | **Required** birinchi fan id si         |
| `second_subject` | `uuid`    | **Required** ikkinchi fan id si         |

```http
  POST /university
```

| Parameter         | Type      | Description                             |
| :---------------- | :-------- | :-------------------------------------- |
| `university_name` | `string`  | **Required** Universitet nomi           |
| `region_id`       | `uuid`    | **Required** shaxar yoki viloyat id si  |

```http
  PUT /university/{university_id}
```
```http
  DELETE /university/{university_id}
```
| Parameter         | Type      | Description                             |
| :---------------- | :-------- | :-------------------------------------- |
| `university_id`   | `uuid`    | **Required** Universitet id si          |
 
 # Tests

```http
  GET /tests
```

| Query            | Type      | Description                             |
| :--------------- | :-------- | :-------------------------------------- |
| `first_subject`  | `uuid`    | **Required** birinchi fan id si         |
| `second_subject` | `uuid`    | **Required** ikkinchi fan id si         |

```http
  POST /test
```

| Parameter           | Type      | Description                              |
| :------------------ | :-------- | :--------------------------------------- |
| `question`          | `string`  | **Required** Savol                       |
| `question_variants` | `object`  | **Required** Savol ni variantlari { 1: Birinchi variant, 2: ikkinchi variant, 3: uchinchi vaiant, 4: tortinchi variant, correct: Togri variant raqami} |
| `subject_id`        | `uuid`    | **Required** Savol ga tegishli fan id si |

```http
  PUT /test/{test_id}
```
```http
  DELETE /test/{test_id}
```
| Parameter         | Type      | Description                             |
| :---------------- | :-------- | :-------------------------------------- |
| `test_id`         | `uuid`    | **Required** Test id si                 |


 # Results

#### User topshirgan testlar va toplagan ballar royxati
```http
  GET /results
```
#### Eng yuqori toplangan ballar
```http
  GET /highest/results
```
#### Id boyicha result olib beradi
```http
  GET /result/{result_id}
```

| Parameter           | Type      | Description                              |
| :------------------ | :-------- | :--------------------------------------- |
| `result_id`         | `uuid`    | **Required** rezultat id si              |

```http
  POST /result
```
| Parameter            | Type      | Description                                               |
| :------------------- | :-------- | :-------------------------------------------------------- |
| `first_subject`      | `integer` | **Required** Birinchi fandan toplagan togri javoblar soni |
| `second_subject`     | `integer` | **Required** Birinchi fandan toplagan togri javoblar soni |
| `first_tests_count`  | `integer` | **Required** Birinchi fandan umumiy testlar soni          |
| `second_tests_count` | `integer` | **Required** Ikkinchi fandan umumiy testlar soni          |
| `faculties`          | `array`   | **Required** Tanlagan facultetlar maksimim 5ta            |
| `time`               | `integer` | **Required** test uchun ketkazgan vaqti (minut da)        |
| `first_subject_id`   | `uuid`    | **Required** Birinchi fan id si                           |
| `second_subject_id`  | `uuid`    | **Required** Ikkinchi fan id di                           |

# Regions
#### Region nomlari va id sini olib beradi

```http
  GET /regions
```
