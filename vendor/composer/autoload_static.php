<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit010ec8bbad4b4e1fe176228cec6eb064
{
    public static $classMap = array (
        'ComposerAutoloaderInit010ec8bbad4b4e1fe176228cec6eb064' => __DIR__ . '/..' . '/composer/autoload_real.php',
        'Composer\\Autoload\\ClassLoader' => __DIR__ . '/..' . '/composer/ClassLoader.php',
        'Composer\\Autoload\\ComposerStaticInit010ec8bbad4b4e1fe176228cec6eb064' => __DIR__ . '/..' . '/composer/autoload_static.php',
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
        'Config' => __DIR__ . '/../..' . '/source/application/config.class.php',
        'Database' => __DIR__ . '/../..' . '/source/application/database.class.php',
        'Nav' => __DIR__ . '/../..' . '/source/application/nav.class.php',
        'views\\View' => __DIR__ . '/../..' . '/source/views/view.class.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->classMap = ComposerStaticInit010ec8bbad4b4e1fe176228cec6eb064::$classMap;

        }, null, ClassLoader::class);
    }
}
