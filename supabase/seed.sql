-- Biostatistikos 11 savaitės viktorina - Koreliacijos ir hipotezės
insert into public.quiz_sets
    (id, name, description)
    values ('c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c', 'Biostatistika 11 savaitė', 'Klausimai apie statistines hipotezes');


select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kas yra p-reikšmė?'::text,
    "order" => 0,
    choices => array[
      '{"body": "Tikimybė gauti tokius pat ar ekstremalesnius duomenis, kai H₀ teisinga", "is_correct": true}'::json,
      '{"body": "Tikimybė, kad nulinė hipotezė H₀ yra teisinga mūsų duomenyse", "is_correct": false}'::json,
      '{"body": "Tikimybė padaryti klaidą atmetus teisingą H₀ (I tipo klaida)", "is_correct": false}'::json,
      '{"body": "Procentinė dalis duomenų, kurie patenka į pasikliautinąjį intervalą", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kaip interpretuoti koreliacijos koeficientą r = -0.85?'::text,
    "order" => 1,
    choices => array[
      '{"body": "Stiprus teigiamas ryšys", "is_correct": false}'::json,
      '{"body": "Silpnas teigiamas ryšys", "is_correct": false}'::json,
      '{"body": "Stiprus neigiamas ryšys", "is_correct": true}'::json,
      '{"body": "Vidutinis teigiamas ryšys", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kada naudoti Spearman koreliaciją vietoj Pearson?'::text,
    "order" => 2,
    choices => array[
      '{"body": "Kai ryšys netiesinis arba duomenys ne normalūs", "is_correct": true}'::json,
      '{"body": "Kai ryšys tiesinis ir duomenys normalūs", "is_correct": false}'::json,
      '{"body": "Kai n < 30", "is_correct": false}'::json,
      '{"body": "Kai p < 0.05", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kas yra H₀ (nulinė hipotezė) koreliacijos uždavinyje (teste)?'::text,
    "order" => 3,
    choices => array[
      '{"body": "r = 0 (nėra ryšio tarp kintamųjų)", "is_correct": true}'::json,
      '{"body": "r ≠ 0 (yra ryšys tarp kintamųjų)", "is_correct": false}'::json,
      '{"body": "r > 0 (teigiamas ryšys)", "is_correct": false}'::json,
      '{"body": "r = 1 (tobulas ryšys)", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Ką reiškia p < 0.05?'::text,
    "order" => 4,
    choices => array[
      '{"body": "Atmetame H₀, rezultatas statistiškai reikšmingas", "is_correct": true}'::json,
      '{"body": "Priimame H₀, rezultatas statistiškai nereikšmingas", "is_correct": false}'::json,
      '{"body": "Yra 5% tikimybė, kad nulinė hipotezė H₀ yra teisinga", "is_correct": false}'::json,
      '{"body": "Koreliacijos koeficientas yra mažesnis už 0.05", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kodėl dažniausiai naudojame α = 0.05 reikšmingumo lygmenį?'::text,
    "order" => 5,
    choices => array[
      '{"body": "Tiesiog įprasta mokslo praktika", "is_correct": true}'::json,
      '{"body": "95% PI yra pats tiksliausias", "is_correct": false}'::json,
      '{"body": "Nes mažesnėms imtims reikia α = 0.05", "is_correct": false}'::json,
      '{"body": "Nes tik su α = 0.05 galime skaičiuoti koreliacijas", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Ką tikriname binom.test() su alternative = "greater" parametru?'::text,
    "order" => 6,
    choices => array[
      '{"body": "Ar proporcija DIDESNĖ už nurodytą p", "is_correct": true}'::json,
      '{"body": "Ar proporcija MAŽESNĖ už nurodytą p", "is_correct": false}'::json,
      '{"body": "Ar proporcija LYGI nurodytai p", "is_correct": false}'::json,
      '{"body": "Ar proporcija SKIRIASI nuo nurodytosios p", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kuri p-reikšmė rodo stipresnį pagrindą atmesti H₀?'::text,
    "order" => 7,
    choices => array[
      '{"body": "p = 0.001", "is_correct": true}'::json,
      '{"body": "p = 0.04", "is_correct": false}'::json,
      '{"body": "p = 0.10", "is_correct": false}'::json,
      '{"body": "p = 0.50", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kokį argumentą naudodami pasirenkami vienpusį ar dvipusį cor.test() funkcijoje?'::text,
    "order" => 8,
    choices => array[
      '{"body": "alternative = ", "is_correct": true}'::json,
      '{"body": "method = ", "is_correct": false}'::json,
      '{"body": "conf.level = ", "is_correct": false}'::json,
      '{"body": "sided = ", "is_correct": false}'::json
    ]
  );

select
  add_question (
    quiz_set_id => 'c7f3a1b2-8d4e-4f6a-9c2b-5e7d8f9a0b1c'::uuid,
    body => 'Kokie argumentai reikalingi ci_binom() funkcijai?'::text,
    "order" => 9,
    choices => array[
      '{"body": "x = sėkmių skaičius, n = bandymų skaičius", "is_correct": true}'::json,
      '{"body": "data = duomenų lentelė, column = stulpelis", "is_correct": false}'::json,
      '{"body": "mean = vidurkis, sd = standartinis nuokrypis", "is_correct": false}'::json,
      '{"body": "formula = y ~ x, data = duomenys", "is_correct": false}'::json
    ]
  );
