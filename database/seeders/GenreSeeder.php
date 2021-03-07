<?php

namespace Database\Seeders;

use Database\Factories\GenreFactory;
use Illuminate\Database\Seeder;

class GenreSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        GenreFactory::times(100)->create();
    }
}
