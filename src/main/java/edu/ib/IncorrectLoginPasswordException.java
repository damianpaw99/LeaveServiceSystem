package edu.ib;

/**
 * Used by logger to signalise that login or password is incorrect
 */
    public class IncorrectLoginPasswordException extends Exception {

        /**
         * Basic constructor
         *
         * @param message Message of error
         */
        public IncorrectLoginPasswordException(String message) {
            super(message);
        }

    }

