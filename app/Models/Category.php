<?php

namespace App\Models;

use App\Models\Traits\Uuid;
use Eloquent;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * App\Models\Category
 *
 * @method static \Illuminate\Database\Eloquent\Builder|Category newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Category newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Category query()
 * @mixin Eloquent
 */
class Category extends Model
{
    use HasFactory, SoftDeletes, Uuid;

    protected $fillable = ['name', 'description', 'is_active'];
    protected $dates = ['deleted_at'];
    protected $casts = [
        'id' => 'string'
    ];


}
