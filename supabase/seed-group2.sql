-- Biostatistikos 11 savaitės viktorina - Koreliacijos ir hipotezės (2 grupė)
insert into public.quiz_sets
    (id, name, description)
    values ('d8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e', 'Biostatistika 11 savaitė (2 grupė)', 'Klausimai apie statistines hipotezes');


select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kas yra p-reikšmė?'::text,
    "order" => 0,
    choices => array[
      '{"body": "Tikimybė padaryti klaidą atmetus teisingą H₀ (I tipo klaida)", "is_correct": false}'::json,
      '{"body": "Tikimybė gauti tokius pat ar ekstremalesnius duomenis, kai H₀ teisinga", "is_correct": true}'::json,
      '{"body": "Procentinė dalis duomenų, kurie patenka į pasikliautinąjį intervalą", "is_correct": false}'::json,
      '{"body": "Tikimybė, kad nulinė hipotezė H₀ yra teisinga mūsų duomenyse", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kaip interpretuoti koreliacijos koeficientą r = 0.78?'::text,
    "order" => 1,
    choices => array[
      '{"body": "Stiprus teigiamas ryšys", "is_correct": true}'::json,
      '{"body": "Silpnas neigiamas ryšys", "is_correct": false}'::json,
      '{"body": "Stiprus neigiamas ryšys", "is_correct": false}'::json,
      '{"body": "Vidutinis teigiamas ryšys", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kada naudoti Pearson koreliaciją vietoj Spearman?'::text,
    "order" => 2,
    choices => array[
      '{"body": "Kai ryšys tiesinis ir duomenys normalūs", "is_correct": true}'::json,
      '{"body": "Kai ryšys netiesinis arba duomenys ne normalūs", "is_correct": false}'::json,
      '{"body": "Kai n < 30", "is_correct": false}'::json,
      '{"body": "Kai p < 0.05", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kas yra H₀ (nulinė hipotezė) koreliacijos uždavinyje (teste)?'::text,
    "order" => 3,
    choices => array[
      '{"body": "r > 0 (teigiamas ryšys)", "is_correct": false}'::json,
      '{"body": "r ≠ 0 (yra ryšys tarp kintamųjų)", "is_correct": false}'::json,
      '{"body": "r = 1 (tobulas ryšys)", "is_correct": false}'::json,
      '{"body": "r = 0 (nėra ryšio tarp kintamųjų)", "is_correct": true}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Ką reiškia p > 0.05?'::text,
    "order" => 4,
    choices => array[
      '{"body": "Atmetame H₀, rezultatas statistiškai reikšmingas", "is_correct": false}'::json,
      '{"body": "Nepriimame H₀, rezultatas statistiškai nereikšmingas", "is_correct": true}'::json,
      '{"body": "Yra 95% tikimybė, kad nulinė hipotezė H₀ yra teisinga", "is_correct": false}'::json,
      '{"body": "Koreliacijos koeficientas yra didesnis už 0.05", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kodėl dažniausiai naudojame α = 0.05 reikšmingumo lygmenį?'::text,
    "order" => 5,
    choices => array[
      '{"body": "Nes mažesnėms imtims reikia α = 0.05", "is_correct": false}'::json,
      '{"body": "Tiesiog įprasta mokslo praktika", "is_correct": true}'::json,
      '{"body": "Nes tik su α = 0.05 galime skaičiuoti koreliacijas", "is_correct": false}'::json,
      '{"body": "95% PI yra pats tiksliausias", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Ką tikriname binom.test() su alternative = "less" parametru?'::text,
    "order" => 6,
    choices => array[
      '{"body": "Ar proporcija MAŽESNĖ už nurodytą p", "is_correct": true}'::json,
      '{"body": "Ar proporcija DIDESNĖ už nurodytą p", "is_correct": false}'::json,
      '{"body": "Ar proporcija LYGI nurodytai p", "is_correct": false}'::json,
      '{"body": "Ar proporcija SKIRIASI nuo nurodytosios p", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kuri p-reikšmė rodo stipresnį pagrindą atmesti H₀?'::text,
    "order" => 7,
    choices => array[
      '{"body": "p = 0.002", "is_correct": true}'::json,
      '{"body": "p = 0.03", "is_correct": false}'::json,
      '{"body": "p = 0.08", "is_correct": false}'::json,
      '{"body": "p = 0.45", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kokį argumentą naudodami pasirenkami vienpusį ar dvipusį cor.test() funkcijoje?'::text,
    "order" => 8,
    choices => array[
      '{"body": "conf.level = ", "is_correct": false}'::json,
      '{"body": "method = ", "is_correct": false}'::json,
      '{"body": "alternative = ", "is_correct": true}'::json,
      '{"body": "sided = ", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'd8a4b2c3-9e5f-5a7b-0d3c-6f8e9a0b2d3e'::uuid,
    body => 'Kokie argumentai reikalingi ci_binom() funkcijai?'::text,
    "order" => 9,
    choices => array[
      '{"body": "mean = vidurkis, sd = standartinis nuokrypis", "is_correct": false}'::json,
      '{"body": "formula = y ~ x, data = duomenys", "is_correct": false}'::json,
      '{"body": "x = sėkmių skaičius, n = bandymų skaičius", "is_correct": true}'::json,
      '{"body": "data = duomenų lentelė, column = stulpelis", "is_correct": false}'::json
    ]
  );
