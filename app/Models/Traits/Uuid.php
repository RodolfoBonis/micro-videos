<?php


namespace App\Models\Traits;

use \Ramsey\Uuid\Uuid as Ramsey;

trait Uuid
{
    public static function boot() {
        parent::boot();
        static::creating(function($obj) {
            $obj->id = Ramsey::uuid4()->toString();
        });
    }
}