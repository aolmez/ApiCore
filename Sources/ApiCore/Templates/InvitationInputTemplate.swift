//
//  InvitationInputTemplate.swift
//  ApiCore
//
//  Created by Ondrej Rafaj on 08/10/2018.
//

import Foundation


public class InvitationInputTemplate: WebTemplate {
    
    public static var name: String = "invitation-web"
    
    public static var html: String = """
<!DOCTYPE html>
<html>
    <head>
        <title>#(system.info.name) - Accept invitation</title>#// Translate all copy!!!!!
        <style>
            * {
                font-family: Helvetica, Arial, sans-serif;
                text-align: center;
            }
            form, body, h2 {
                margin-top: 44px;
            }
            body {
                width: 300px;
                margin-left: auto;
                margin-right: auto;
            }
            img {
                width: 98px;
                border-radius: 5px;
            }
            h1 {
                font-size: large;
                color: #434343;
            }
            h2 {
                font-size: medium;
                margin-bottom: 44px;
                color: #818181;
            }
            p.input {
                text-align: left;
            }
            label {
                
            }
            input {
                width: 300px;
                border: solid 1px #eeeeee;
                border-radius: 4px;
                text-align: left;
                padding: 12px 4px 12px 4px;
                margin-top: 6px;
                font-size: small;
            }
            input[disabled] {
                background-color: #F6F6F6;
            }
            button {
                margin-top: 22px;
                color: white;
                background-color: #5f80b5;
                border: none;
                border-radius: 4px;
                font-size: medium;
                padding-top: 8px;
                padding-bottom: 8px;
                padding-left: 12px;
                padding-right: 12px;
            }

        </style>
        <script type="text/javascript">
            window.onload = function () {
                var input = document.getElementById('username');
                input.focus();
                input.select();
            }
        </script>
    </head>
    <body>
        <p><img src="#(system.info.url)/server/image/256" alt="#(system.info.name)" /></p>
        <h1>Hi #(user.firstname) #(user.lastname)</h1>
        #/*
            #(finish) contains an API link to which you need to send the form data either as JSON data or as a standard webform.
            You can also append a target URL to redirect the user to when done by appending '&target=http://example.com/all_is_dandy'.
            Target is an optional value and if not set a JSON (API) result will be returned.
        */
        <form method="post" action="#(finish)">
            <h2>Please finish your #(system.info.name) registration here:</h2>
            <p class="input">
                <label>Email:</label> <input id="email" name="email" type="email" value="#(user.email)" disabled />
            </p>
            <p class="input">
                <label>Username:</label> <input id="username" name="username" type="text" value="#(user.username)" />
            </p>
            <p class="input">
                <label>Firstname:</label> <input id="firstname" name="firstname" type="text" value="#(user.firstname)" />
            </p>
            <p class="input">
                <label>Lastname:</label> <input id="lastname" name="lastname" type="text" value="#(user.lastname)" />
            </p>
            <!-- TODO: Check password is valid against the validation endpoint + check the verification password matches it -->
            <p class="input">
                <label>Password:</label> <input id="password" name="password" type="password" value="" />
            </p>
            <p class="input">
                <label>Password again:</label> <input id="verification" name="verification" type="password" value="" />
            </p>
            <p><button type="submit">Save</button></p>
        </form>
    </body>
</html>
"""
    
}
