<?php

# Author: Jay Annadurai
# Project: DriftveilLabs
# File: View.class.php
# Desc: Master View Class

namespace views;
class View
{

    # Method to generate a Page Header
    protected static function header()
    {
        ?>

        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title> Hello World </title>
        </head>
        <body>

        </body>
        </html>

        <?php
    }

} # End of View Class